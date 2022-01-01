import 'dart:async';

import 'package:flutter/material.dart';
import 'package:heleapp/app/app_prefs.dart';
import 'package:heleapp/app/di.dart';
import 'package:heleapp/presentation/resources/Color_Manager.dart';
import 'package:heleapp/presentation/resources/assets_manager.dart';
import 'package:heleapp/presentation/resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  AppPrefrences _appPrefrences = instance<AppPrefrences>();

  Timer? _timer;

  _startDlay() {
    _timer = Timer(Duration(seconds: 2), _goNext);
  }

  _goNext() async {
    _appPrefrences.isUserLoggedIn().then((isUserLoggedIn) => {
          if (isUserLoggedIn)
            {
              // navigate to main screen
              Navigator.pushReplacementNamed(context, Routes.mainRoute)
            }
          else
            {
              _appPrefrences
                  .isOnBoardingScreenViewed()
                  .then((isOnBoardingScreenViewed) => {
                        if (isOnBoardingScreenViewed)
                          {
                            Navigator.pushReplacementNamed(
                                context, Routes.loginRoute)
                          }
                        else
                          {
                            Navigator.pushReplacementNamed(
                                context, Routes.onBoardingRoute)
                          }
                      })
            }
        });
  }

  @override
  void initState() {
    super.initState();
    _startDlay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(
        child: Image(
          image: AssetImage(ImageAssets.splashLogo),
        ),
      ),
    );
  }
}
