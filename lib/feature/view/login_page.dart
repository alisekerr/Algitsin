import 'package:algitsin/core/extensions/size_extention.dart';
import 'package:algitsin/feature/service/auth/auth_service.dart';
import 'package:algitsin/feature/service/auth/i_auth_service.dart';
import 'package:algitsin/feature/view/home_page.dart';
import 'package:algitsin/feature/view/register_bottom_sheet.dart';
import 'package:algitsin/feature/viewmodel/switch_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SellerLogin extends StatefulWidget {
  const SellerLogin({Key? key}) : super(key: key);

  @override
  _SellerLoginState createState() => _SellerLoginState();
}

var switchState = SwitchState(title: "Create seller account", value: false);


class _SellerLoginState extends State<SellerLogin> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  
  AuthService authService =AuthService();
   
  bool isVisibility = true;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
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
              buildSignInButton(context, emailController, passwordController),
              buildPadding8(),
              buildSellerSwitch(context, theme),
              RegisterBottomSheet()
            ],
          ),
        ),
      ),
    );
  }

  Row buildSellerSwitch(BuildContext context, TextTheme theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Satıcı olarak kayıt ol",
          style: theme.subtitle2,
        ),
        Switch.adaptive(
            activeColor: Theme.of(context).primaryColor,
            activeTrackColor: Theme.of(context).primaryColor.withOpacity(0.75),
            value: switchState.value,
            onChanged: (value) {
              setState(() {
                switchState.setBool(value);
              });
            }),
      ],
    );
  }

  SizedBox buildSignInButton(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController) {
    var theme = Theme.of(context).textTheme;
    return SizedBox(
      width: 343.0.w,
      height: 57.0.h,
      child: ElevatedButton(
        onPressed: () async {
          await authService
              .signIn(emailController.text, passwordController.text)
              .then((value) => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage())));
        },
        child: Text(
          "Giriş Yap",

          style: theme.button!.copyWith(color: Colors.white),
        ),
        style:
            ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
      ),
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
