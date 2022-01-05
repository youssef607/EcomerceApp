import 'package:flutter/material.dart';
import 'package:heleapp/app/app_prefs.dart';
import 'package:heleapp/app/di.dart';
import 'package:heleapp/presentation/resources/routes_manager.dart';
import 'package:heleapp/presentation/resources/theme_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class MyApp extends StatefulWidget {
  MyApp._internal();
  static final MyApp instance = MyApp._internal();
  factory MyApp() => instance;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppPrefrences _appPrefrences = instance<AppPrefrences>();
  @override
  void didChangeDependencies() {
    _appPrefrences.getLocal().then((local) => {context.setLocale(local)});

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splashRoute,
        theme: getApplicationTheme());
  }
}
