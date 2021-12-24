import 'package:flutter/material.dart';
import 'package:heleapp/app/app.dart';
import 'package:heleapp/app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
}
