import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:heleapp/app/app_prefs.dart';
import 'package:heleapp/app/di.dart';
import 'package:heleapp/presentation/common/state_rendrer/state_renderer_impl.dart';
import 'package:heleapp/presentation/login/login_viewmodel.dart';
import 'package:heleapp/presentation/resources/Color_Manager.dart';
import 'package:heleapp/presentation/resources/assets_manager.dart';
import 'package:heleapp/presentation/resources/routes_manager.dart';
import 'package:heleapp/presentation/resources/strings_manager.dart';
import 'package:heleapp/presentation/resources/values_manager.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginViewModel _viewModel = instance<LoginViewModel>();
  AppPrefrences _appPrefrences = instance<AppPrefrences>();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));

    _viewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((isSeccessLoggesIn) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        _appPrefrences.isUserLoggedIn();
        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
      });
    });
  }

  @override
  void initState() {
    _bind();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                    () {
                  _viewModel.login();
                }) ??
                _getContentWidget();
          }),
    );
  }

  Widget _getContentWidget() {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p100),
      child: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image(image: AssetImage(ImageAssets.splashLogo)),
                SizedBox(
                  height: AppSize.s28,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsUserNameValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: _userNameController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: AppStrings.username,
                            labelText: AppStrings.username,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.usernameError),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: AppSize.s28,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsPasswordValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: AppStrings.password,
                            labelText: AppStrings.password,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.passwordError),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: AppSize.s28,
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
                                      _viewModel.login();
                                    }
                                  : null,
                              child: Text(AppStrings.login)),
                        );
                      },
                    )),
                Padding(
                  padding: EdgeInsets.only(
                    top: AppPadding.p8,
                    left: AppPadding.p28,
                    right: AppPadding.p28,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.forgotPasswordRoute);
                          },
                          child: Text(
                            AppStrings.forgetPassword,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.registerRoute);
                          },
                          child: Text(
                            AppStrings.registerText,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
