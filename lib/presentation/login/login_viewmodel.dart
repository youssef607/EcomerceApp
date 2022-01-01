import 'dart:async';

import 'package:heleapp/data/network/failure.dart';
import 'package:heleapp/domain/usecase/login_usecase.dart';
import 'package:heleapp/presentation/base/baseviewmodel.dart';
import 'package:heleapp/presentation/common/freezed_data_classes.dart';
import 'package:heleapp/presentation/common/state_rendrer/state_renderer_impl.dart';
import 'package:heleapp/presentation/common/state_rendrer/state_rendrer.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();

  StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>();

  var loginOject = LoginObject("", "");

  LoginUseCase _loginUseCase; //remove
  LoginViewModel(this._loginUseCase);

  //Inputs
  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  login() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginOject.userName, loginOject.password)))
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
  setPassword(String password) {
    inputPassword.add(password);
    loginOject = loginOject.copyWith(password: password);
    _validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginOject = loginOject.copyWith(userName: userName);
    _validate();
  }

  @override
  Sink get inputisAllInputValid => _isAllInputsValidStreamController.sink;

//outPuts
  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordvalid(password));

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNamevalid(userName));

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());

  // private fnctions
  _validate() {
    inputisAllInputValid.add(null);
  }

  _isPasswordvalid(String password) {
    return password.isNotEmpty;
  }

  _isUserNamevalid(String username) {
    return username.isNotEmpty;
  }

  bool _isAllInputsValid() {
    return _isPasswordvalid(loginOject.password) &&
        _isUserNamevalid(loginOject.userName);
  }
}

abstract class LoginViewModelInputs {
  setUserName(String userName);
  setPassword(String password);
  login();

  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputisAllInputValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputIsAllInputsValid;
}
