import 'package:flutter/material.dart';
import 'package:heleapp/presentation/resources/strings_manager.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(AppStrings.settings),
    );
  }
}
