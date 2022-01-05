import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:heleapp/app/app.dart';
import 'package:heleapp/app/di.dart';
import 'package:heleapp/presentation/resources/language_maager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(EasyLocalization(
    supportedLocales: [ENGLISH_LOCAL, ARABIC_LOCAL],
    path: ASSETS_PATH_LOCALISATION,
    child: Phoenix(child: MyApp()),
  ));
}
