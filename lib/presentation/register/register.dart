import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heleapp/app/app_prefs.dart';
import 'package:heleapp/app/di.dart';
import 'package:heleapp/data/mapper/mapper.dart';
import 'package:heleapp/presentation/common/state_rendrer/state_renderer_impl.dart';
import 'package:heleapp/presentation/register/register_viewmodel.dart';
import 'package:heleapp/presentation/resources/Color_Manager.dart';
import 'package:heleapp/presentation/resources/assets_manager.dart';
import 'package:heleapp/presentation/resources/routes_manager.dart';
import 'package:heleapp/presentation/resources/strings_manager.dart';
import 'package:heleapp/presentation/resources/values_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';

class RegisterView extends StatefulWidget {
  RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterViewModel _viewModel = instance<RegisterViewModel>();
  AppPrefrences _appPrefrences = instance<AppPrefrences>();

  ImagePicker picker = instance<ImagePicker>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _userNameTextEditingController =
      TextEditingController();
  TextEditingController _mobileNumberEditingController =
      TextEditingController();
  TextEditingController _userEmailTextEditingController =
      TextEditingController();
  TextEditingController _userPasswordTextEditingController =
      TextEditingController();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _viewModel.start();
    _userNameTextEditingController.addListener(() {
      _viewModel.setUserName(_userNameTextEditingController.text);
    });
    _userPasswordTextEditingController.addListener(() {
      _viewModel.setPassword(_userPasswordTextEditingController.text);
    });
    _userEmailTextEditingController.addListener(() {
      _viewModel.setEmail(_userEmailTextEditingController.text);
    });
    _mobileNumberEditingController.addListener(() {
      _viewModel.setMobileNumber(_mobileNumberEditingController.text);
    });
    _viewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((isSeccessLoggesIn) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        _appPrefrences.setIsUserLoggedIn();
        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
      });
    });
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        elevation: AppSize.s0,
        iconTheme: IconThemeData(color: ColorManager.black),
        backgroundColor: ColorManager.white,
      ),
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return Center(
              child: snapshot.data
                      ?.getScreenWidget(context, _getContentWidget(), () {
                    _viewModel.register();
                  }) ??
                  _getContentWidget(),
            );
          }),
    );
  }

  Widget _getContentWidget() {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p30),
      child: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image(image: AssetImage(ImageAssets.splashLogo)),
                // SizedBox(
                //   height: AppSize.s12,
                // ),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorUserName,
                    builder: (context, snapshot) {
                      return TextFormField(
                          controller: _userNameTextEditingController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: AppStrings.username.tr(),
                              labelText: AppStrings.username.tr(),
                              errorText: snapshot.data));
                    },
                  ),
                ),
                // SizedBox(
                //   height: AppSize.s12,
                // ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: AppPadding.p12,
                        left: AppPadding.p28,
                        right: AppPadding.p28,
                        bottom: AppPadding.p12),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: CountryCodePicker(
                              onChanged: (country) {
                                _viewModel
                                    .setCountryCode(country.dialCode ?? EMPTY);
                              },
                              initialSelection: "+212",
                              showCountryOnly: true,
                              hideMainText: true,
                              showOnlyCountryWhenClosed: true,
                              favorite: ["+212", "+33"],
                            )),
                        Expanded(
                          flex: 3,
                          child: StreamBuilder<String?>(
                            stream: _viewModel.outputErrorMobileNumber,
                            builder: (context, snapshot) {
                              return TextFormField(
                                  controller: _mobileNumberEditingController,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      hintText: AppStrings.mobileNumber.tr(),
                                      labelText: AppStrings.mobileNumber.tr(),
                                      errorText: snapshot.data));
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // SizedBox(
                //   height: AppSize.s12,
                // ),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorEmail,
                    builder: (context, snapshot) {
                      return TextFormField(
                          controller: _userEmailTextEditingController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: AppStrings.emailHint.tr(),
                              labelText: AppStrings.emailHint.tr(),
                              errorText: snapshot.data));
                    },
                  ),
                ),
                SizedBox(
                  height: AppSize.s12,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorPassword,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: _userPasswordTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: AppStrings.password.tr(),
                            labelText: AppStrings.password.tr(),
                            errorText: snapshot.data),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: AppSize.s12,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: Container(
                    height: AppSize.s40,
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorManager.lightGrey)),
                    child: GestureDetector(
                      child: _getMediaWidget(),
                      onTap: () {
                        _showPicker(context);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSize.s12,
                ),
                Padding(
                    padding: EdgeInsets.only(
                        left: AppPadding.p28, right: AppPadding.p28),
                    child: StreamBuilder<bool>(
                      stream: _viewModel.outputIsAllInputsValid,
                      builder: (context, snapshot) {
                        return SizedBox(
                          width: double.infinity,
                          height: AppSize.s40,
                          child: ElevatedButton(
                              onPressed: (snapshot.data ?? false)
                                  ? () {
                                      _viewModel.register();
                                    }
                                  : null,
                              child: Text(AppStrings.register).tr()),
                        );
                      },
                    )),
                Padding(
                  padding: EdgeInsets.only(
                    top: AppPadding.p8,
                    left: AppPadding.p28,
                    right: AppPadding.p28,
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppStrings.haveAccount,
                        style: Theme.of(context).textTheme.subtitle2,
                      ).tr(),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget _getMediaWidget() {
    return Padding(
      padding: EdgeInsets.only(left: AppPadding.p8, right: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(AppStrings.profilePicture).tr()),
          Flexible(
              child: StreamBuilder<File>(
            stream: _viewModel.outputIsProfilePictureValid,
            builder: (context, snapshot) {
              return _imagePickedByUser(snapshot.data);
            },
          )),
          Flexible(child: SvgPicture.asset(ImageAssets.photoCameraIc)),
        ],
      ),
    );
  }

  Widget _imagePickedByUser(File? image) {
    if (image != null && image.path.isNotEmpty) {
      return Image.file(image);
    } else {
      return Container();
    }
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                trailing: Icon(Icons.arrow_forward),
                leading: Icon(Icons.camera),
                title: Text(AppStrings.photoGalley).tr(),
                onTap: () {
                  _imageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                trailing: Icon(Icons.arrow_forward),
                leading: Icon(Icons.camera_alt_rounded),
                title: Text(AppStrings.photoCamera).tr(),
                onTap: () {
                  _imageFromCamera();
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
        });
  }

  _imageFromGallery() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  _imageFromCamera() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }
}
