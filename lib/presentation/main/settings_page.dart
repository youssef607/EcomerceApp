import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heleapp/app/app_prefs.dart';
import 'package:heleapp/app/di.dart';
import 'package:heleapp/data/data_source/local_data_source.dart';
import 'package:heleapp/presentation/resources/assets_manager.dart';
import 'package:heleapp/presentation/resources/language_maager.dart';
import 'package:heleapp/presentation/resources/routes_manager.dart';
import 'package:heleapp/presentation/resources/strings_manager.dart';
import 'package:heleapp/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:math' as math;

class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  AppPrefrences _appPrefrences = instance<AppPrefrences>();
  LocalDataSource _localDataSource = instance<LocalDataSource>();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(AppPadding.p8),
      children: [
        ListTile(
          title: Text(AppStrings.changeLanguage,
                  style: Theme.of(context).textTheme.headline4)
              .tr(),
          leading: SvgPicture.asset(ImageAssets.changeLangIc),
          trailing: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
            child: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
          ),
          onTap: () {
            _changeLanguage();
          },
        ),
        ListTile(
          title: Text(AppStrings.contactUs,
                  style: Theme.of(context).textTheme.headline4)
              .tr(),
          leading: SvgPicture.asset(ImageAssets.contactUsIc),
          trailing: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
            child: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
          ),

          // SvgPicture.asset(ImageAssets.settingsRightArrowIc),
          onTap: () {
            _contactUs();
          },
        ),
        ListTile(
          title: Text(AppStrings.inviteYourFriends,
                  style: Theme.of(context).textTheme.headline4)
              .tr(),
          leading: SvgPicture.asset(ImageAssets.inviteFriendsIc),
          trailing: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
            child: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
          ),
          // SvgPicture.asset(ImageAssets.settingsRightArrowIc),
          onTap: () {
            _inviteFriends();
          },
        ),
        ListTile(
          title: Text(AppStrings.logout,
                  style: Theme.of(context).textTheme.headline4)
              .tr(),
          leading: SvgPicture.asset(ImageAssets.logoutIc),
          trailing: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
            child: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
          ),
          // SvgPicture.asset(ImageAssets.settingsRightArrowIc),
          onTap: () {
            _lougOut();
          },
        ),
      ],
    );
  }

  void _changeLanguage() {
    _appPrefrences.setLanguageChanged();
    Phoenix.rebirth(context);
  }

  void _contactUs() {}
  void _inviteFriends() {}
  void _lougOut() {
    _appPrefrences.logout();
    _localDataSource.clearCache();
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }

  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
}
