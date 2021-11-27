
import 'package:algitsin/constants/theme_data.dart';
import 'package:algitsin/extensions/size_config.dart';
import 'package:algitsin/feature/algitsin/view/control_page.dart';
import 'package:algitsin/feature/algitsin/view/home_page.dart';
import 'package:algitsin/feature/algitsin/view/login_page.dart';
import 'package:algitsin/feature/algitsin/view/welcome_page.dart';
import 'package:flutter/material.dart';

void main() {

  runApp(const MaterialApp(
     
      debugShowCheckedModeBanner: false,
      home:  MyApp()));
}

class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig(context).init();

    return MaterialApp(
     theme:algitsinThemeData,
      debugShowCheckedModeBanner: false,
      home:  const HomePage());
  }
}
