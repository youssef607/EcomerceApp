import 'package:flutter/material.dart';
import 'package:heleapp/presentation/resources/strings_manager.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(AppStrings.search),
    );
  }
}
