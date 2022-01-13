import 'dart:math';

import 'package:algitsin/core/extensions/size_extention.dart';
import 'package:algitsin/feature/service/auth/auth_service.dart';
import 'package:algitsin/feature/service/auth/google_signin_provider.dart';
import 'package:algitsin/feature/view/control_page.dart';
import 'package:algitsin/feature/view/google_landing.dart';
import 'package:algitsin/feature/view/landing_page.dart';
import 'package:algitsin/feature/view/loading_page.dart';
import 'package:algitsin/feature/view/register_page.dart';
import 'package:algitsin/product/widgets/base_button.dart';
import 'package:algitsin/product/widgets/switch_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}
bool _isVisibility=false;
var switchState = SwitchState(title: "Create seller account", value: false);
final FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  GoogleSigninProvider googleSignin = GoogleSigninProvider();
  AuthService authService = AuthService();
  bool isVisibility = true;
  bool _loadingVisible = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() => setState(() {}));
  }

  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    buttonGoogleSignIn() async {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      await _changeLoadingVisible();

      final provider =
          Provider.of<GoogleSigninProvider>(context, listen: false);
      await provider.googleLogin().then((value) {
        if (value == true) {
          setState(() async {
            await _changeLoadingVisible();
          });
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const GoogleLanding()),
              (route) => false);
        }
      });
    }

    buttonSignIn() async {
      try {
        await authService
            .signIn(emailController.text, passwordController.text)
            .then((value) => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LandingPage()),
                (route) => false));
      } catch (e) {
       setState(() {
         _isVisibility=true;
       });
      
      }
    }

    return Scaffold(
      body: LoadingPage(
        inAsyncCall: _loadingVisible,
        child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/welcome-icon.png"),
                Text(
                  "Algitsin'e hoşgeldin",
                  style: theme.caption,
                ),
                Text(
                  "Devam Etmek İçin Giriş Yapınız",
                  style: theme.subtitle2,
                ),
                buildPadding8(),
                buildEmailTextField(),
                buildPadding8(),
                buildPasswordTextField(),
                buildPadding8(),
                BaseButton(
                    function: buttonSignIn,
                    icon: const FaIcon(FontAwesomeIcons.signInAlt),
                    text: "Giriş Yap"),
                buildPadding8(),
                BaseButton(
                    function: buttonGoogleSignIn,
                    icon: const FaIcon(FontAwesomeIcons.google),
                    text: "Google İle Giriş Yap"),
                buildPadding8(),
                buildRegisterText(context, theme),
                  Visibility(
                   visible: _isVisibility,
                   child: const Text(
                    "Lütfen Gerekli Bilgileri Doğru Giriniz !",
                    style: TextStyle(color: Colors.red),
                                 ),
                 )
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector buildRegisterText(BuildContext context, TextTheme theme) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const RegisterPage()));
      },
      child: RichText(
          text: TextSpan(children: [
        TextSpan(text: "Bir heabın yok mu ? ", style: theme.subtitle2),
        TextSpan(
            text: "Kayıt ol",
            style: theme.subtitle2!.copyWith(
                color: const Color(0xff55f7b9), fontWeight: FontWeight.bold))
      ])),
    );
  }

  SizedBox buildPadding8() {
    return SizedBox(
      height: 8.0.h,
    );
  }

  Widget buildPasswordTextField() => Theme(
        data: Theme.of(context).copyWith(
            colorScheme: ThemeData()
                .colorScheme
                .copyWith(primary: Theme.of(context).primaryColor)),
        child: SizedBox(
          width: 343.0.w,
          height: 48.0.h,
          child: TextField(
              controller: passwordController,
              obscureText: isVisibility,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0.5.sp),
                enabledBorder: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 2)),
                hintText: "Şifre Giriniz",
                prefixIcon: const Icon(Icons.password),
                suffixIcon: IconButton(
                  icon: isVisibility
                      ? const Icon(Icons.visibility_off)
                      : const Icon(
                          Icons.visibility,
                        ),
                  onPressed: () {
                    setState(() {
                      isVisibility = !isVisibility;
                    });
                  },
                ),
              )),
        ),
      );

  Widget buildEmailTextField() {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Theme.of(context).primaryColor,
            ),
      ),
      child: SizedBox(
        width: 343.0.w,
        height: 43.0.h,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0.5.sp),
              enabledBorder: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2)),
              prefixIcon: const Icon(
                Icons.email,
              ),
              suffixIcon: emailController.text.isEmpty
                  ? Container(width: 0)
                  : IconButton(
                      onPressed: () {
                        emailController.clear();
                      },
                      icon: const Icon(Icons.close)),
              hintText: "Email Giriniz"),
        ),
      ),
    );
  }
}
