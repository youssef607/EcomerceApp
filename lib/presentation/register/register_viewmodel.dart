import 'dart:async';
import 'dart:io';
import 'package:heleapp/app/functions.dart';
import 'package:heleapp/domain/usecase/register_usecase.dart';
import 'package:heleapp/presentation/base/baseviewmodel.dart';
import 'package:heleapp/presentation/common/freezed_data_classes.dart';
import 'package:heleapp/presentation/common/state_rendrer/state_renderer_impl.dart';
import 'package:heleapp/presentation/common/state_rendrer/state_rendrer.dart';

class RegisterViewModel extends BaseViewModel
    with registerViewModelInput, registerViewModelOutput {
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();

  StreamController _mobileNumberStreamController =
      StreamController<String>.broadcast();
  StreamController _emailStreamController =
      StreamController<String>.broadcast();
  StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  StreamController _profilePictureStreamController =
      StreamController<File>.broadcast();

  StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>();

  RegisterUseCase _registerUseCase;

  var registerViewObject = RegisterObject("", "", "", "", "", "");
  RegisterViewModel(this._registerUseCase);

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  register() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _registerUseCase.execute(RegisterUseCaseInput(
            registerViewObject.mobileNumber,
            registerViewObject.countryMobileCode,
            registerViewObject.userName,
            registerViewObject.email,
            registerViewObject.password,
            registerViewObject.profilePicture)))
        .fold(
            (failure) => {
                  inputState.add(ErrorState(
                      StateRendererType.POPUP_ERROR_STATE, failure.message))
                }, (data) {
      inputState.add(ContentState());
      isUserLoggedInSuccessfullyStreamController.add(true);
    });
  }

  @override
  void dispose() {
    _profilePictureStreamController.close();
    _userNameStreamController.close();
    _mobileNumberStreamController.close();
    _passwordStreamController.close();
    _emailStreamController.close();
    _isAllInputsValidStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();

    super.dispose();
  }

  @override
  setCountryCode(String countryCode) {
    if (countryCode.isNotEmpty) {
      registerViewObject =
          registerViewObject.copyWith(countryMobileCode: countryCode);
    } else {
      registerViewObject = registerViewObject.copyWith(countryMobileCode: "");
    }
    _validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (isEmailValid(email)) {
      registerViewObject = registerViewObject.copyWith(email: email);
    } else {
      registerViewObject = registerViewObject.copyWith(email: "");
    }
    _validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if (_isMobileNumberValid(mobileNumber)) {
      registerViewObject =
          registerViewObject.copyWith(mobileNumber: mobileNumber);
    } else {
      registerViewObject = registerViewObject.copyWith(mobileNumber: "");
    }
    _validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_isPasswordValid(password)) {
      registerViewObject = registerViewObject.copyWith(password: password);
    } else {
      registerViewObject = registerViewObject.copyWith(password: "");
    }
    _validate();
  }

  @override
  setProfilePicture(File file) {
    inputProfilePicture.add(file);
    if (file.path.isNotEmpty) {
      registerViewObject =
          registerViewObject.copyWith(profilePicture: file.path);
    } else {
      registerViewObject =
          registerViewObject.copyWith(profilePicture: file.path);
    }
    _validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if (_isUserNameValid(userName)) {
      registerViewObject = registerViewObject.copyWith(userName: userName);
    } else {
      registerViewObject = registerViewObject.copyWith(userName: "");
    }
    _validate();
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputMobileNumber => _mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => _profilePictureStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputAllInputsValid => _isAllInputsValidStreamController.sink;

  //-- outputs Error Email

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _validateAlInputs());

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<String?> get outputErrorUserName => outputIsUserNameValid
      .map((isUserNameValid) => isUserNameValid ? null : "invalid userName");

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<String?> get outputErrorEmail => outputIsEmailValid
      .map((isEmailValid) => isEmailValid ? null : "invalid Email");

  @override
  Stream<bool> get outputIsMobileNumberValid =>
      _mobileNumberStreamController.stream
          .map((mobileNumber) => _isMobileNumberValid(mobileNumber));

  @override
  Stream<String?> get outputErrorMobileNumber =>
      outputIsMobileNumberValid.map((isMobileNumberValid) =>
          isMobileNumberValid ? null : "invalid Mobile Number");

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid
      .map((isPasswordValid) => isPasswordValid ? null : "invalid password");

  @override
  Stream<File> get outputIsProfilePictureValid =>
      _profilePictureStreamController.stream.map((file) => file);

  //--private methodes
  bool _isUserNameValid(String userName) {
    return userName.length >= 8;
  }

  bool _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.length >= 10;
  }

  bool _isPasswordValid(String password) {
    return password.length >= 8;
  }

  bool _validateAlInputs() {
    return registerViewObject.profilePicture.isNotEmpty &&
        registerViewObject.email.isNotEmpty &&
        registerViewObject.password.isNotEmpty &&
        registerViewObject.mobileNumber.isNotEmpty &&
        registerViewObject.userName.isNotEmpty &&
        registerViewObject.countryMobileCode.isNotEmpty;
  }

  _validate() {
    inputAllInputsValid.add(null);
  }
}

abstract class registerViewModelInput {
  register();

  setUserName(String userName);
  setMobileNumber(String mobileNumber);
  setCountryCode(String countryCode);
  setEmail(String email);
  setPassword(String password);
  setProfilePicture(File file);

  Sink get inputUserName;
  Sink get inputMobileNumber;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputProfilePicture;
  Sink get inputAllInputsValid;
}

abstract class registerViewModelOutput {
  Stream<bool> get outputIsUserNameValid;
  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsMobileNumberValid;
  Stream<String?> get outputErrorMobileNumber;

  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPassword;

  Stream<File> get outputIsProfilePictureValid;
  Stream<bool> get outputIsAllInputsValid;
}
