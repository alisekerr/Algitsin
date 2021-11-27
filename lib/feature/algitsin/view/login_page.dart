
import 'package:algitsin/extensions/size_extention.dart';
import 'package:algitsin/feature/algitsin/viewmodel/switch_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sliding_sheet/sliding_sheet.dart';

class SellerLogin extends StatefulWidget {
  const SellerLogin({Key? key}) : super(key: key);

  @override
  _SellerLoginState createState() => _SellerLoginState();
}

var switchState = SwitchState(title: "Create seller account", value: false);
bool denemee = false;

class _SellerLoginState extends State<SellerLogin> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
      backgroundColor: Theme.of(context).dialogBackgroundColor,
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
              buildSignInButton(context),
              buildPadding8(),
              buildSellerSwitch(context, theme),
              buildRegisterTextButton(theme),
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
            activeTrackColor:
                Theme.of(context).primaryColor.withOpacity(0.75),
            value: switchState.value,
            onChanged: (value) {
              setState(() {
                switchState.setBool(value);
              });
            }),
      ],
    );
  }

  GestureDetector buildRegisterTextButton(TextTheme theme) {
    return GestureDetector(
      onTap: () {
        /*  Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SellerRegister()));*/
        showSlidingBottomSheet(context,
            builder: (context) => SlidingSheetDialog(
                cornerRadius: 16,
                elevation:8,
                avoidStatusBar: true,
                snapSpec: const SnapSpec(initialSnap: 0.7, snappings: [0.7, 1]),
                builder: buildSheet));
      },
      child: RichText(
          text: TextSpan(children: [
        TextSpan(text: "Bir heabın yok mu ? ", style: theme.subtitle2),
        TextSpan(
            text: "Kayıt ol",
            style: theme.overline!.copyWith(color: const Color(0xff55f7b9)))
      ])),
    );
  }

  SizedBox buildSignInButton(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return SizedBox(
      width: 343.0.w,
      height: 57.0.h,
      child: ElevatedButton(
        onPressed: () {},
        child:  Text("Giriş Yap",style:theme.button!.copyWith(color: Colors.white) ,),
        style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor),
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
                        color: Theme.of(context).primaryColor,
                        width: 2)),
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
                      color: Theme.of(context).primaryColor,
                      width: 2)),
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

  Widget buildSheet(BuildContext context, SheetState state) {
    var theme = Theme.of(context).textTheme;

    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(14.0.spByWidth),
            child: Column(
              children: [
                Image.asset("assets/welcome-icon.png"),
                Text(
                  "Hadi Başalayalım",
                  style: theme.caption,
                ),
                Text(
                  "Yeni bir hesap oluşturalım",
                  style: theme.subtitle2,
                ),
                buildPadding8(),
                buildRegisterNameTextField(),
                buildPadding8(),
                buildRegisterEmailTextField(),
                buildPadding8(),
                buildRegisterPasswordTextField(),
                buildPadding8(),
                buildRegisterButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildRegisterNameTextField() {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Theme.of(context).primaryColor,
            ),
      ),
      child: SizedBox(
        width: 343.0.w,
        height: 48.0.h,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0.5.sp),
              enabledBorder: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2)),
              prefixIcon: const Icon(
                Icons.account_circle,
              ),
              suffixIcon: emailController.text.isEmpty
                  ? Container(width: 0)
                  : IconButton(
                      onPressed: () {
                        emailController.clear();
                      },
                      icon: const Icon(Icons.close)),
              hintText: "Full Name"),
        ),
      ),
    );
  }

  buildRegisterEmailTextField() {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Theme.of(context).primaryColor,
            ),
      ),
      child: SizedBox(
        width: 343.0.w,
        height: 48.0.h,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0.5.sp),
              enabledBorder: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2)),
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
              hintText: "Your Email"),
        ),
      ),
    );
  }

  buildRegisterPasswordTextField() {
    return Column(
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: Theme.of(context).primaryColor,
                ),
          ),
          child: SizedBox(
            width: 343.0.w,
            height: 48.0.h,
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0.5.sp),
                  enabledBorder: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2)),
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
                  hintText: "Password"),
            ),
          ),
        ),
        buildPadding8(),
        Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: Theme.of(context).primaryColor,
                ),
          ),
          child: SizedBox(
            width: 343.0.w,
            height: 48.0.h,
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0.5.sp),
                  enabledBorder: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2)),
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
                  hintText: "Password Again"),
            ),
          ),
        )
      ],
    );
  }

  buildRegisterButton(BuildContext context) {
    return SizedBox(
      width: 343.0.w,
      height: 57.0.h,
      child: ElevatedButton(
        onPressed: () {},
        child: const Text("Kayıt Ol"),
        style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor),
      ),
    );
  }

}
