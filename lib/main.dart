
import 'package:algitsin/constants/theme_data.dart';
import 'package:algitsin/core/extensions/size_config.dart';
import 'package:algitsin/feature/view/control_page.dart';
import 'package:algitsin/feature/view/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home:  const ControlPage());
  }
}
