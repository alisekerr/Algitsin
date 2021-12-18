import 'package:algitsin/core/extensions/size_extention.dart';
import 'package:algitsin/feature/service/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class RegisterBottomSheet extends StatelessWidget {
  const RegisterBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        showSlidingBottomSheet(context,
            builder: (context) => SlidingSheetDialog(
                cornerRadius: 16,
                elevation: 8,
                avoidStatusBar: true,
                snapSpec: const SnapSpec(initialSnap: 0.7, snappings: [0.7, 1]),
                builder: buildSheet));
      },
      child: RichText(
          text: TextSpan(children: [
        TextSpan(text: "Bir heabın yok mu ? ", style: theme.subtitle2),
        TextSpan(
            text: "Kayıt ol",
            style: theme.subtitle2!.copyWith(color: const Color(0xff55f7b9),fontWeight: FontWeight.bold))
      ])),
    );
  }

  Widget buildSheet(BuildContext context, SheetState state) {
    var theme = Theme.of(context).textTheme;
    AuthService authService = AuthService();

    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController passwordAgainController =
        TextEditingController();

    return Material(
      color: Colors.white,
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
              buildRegisterNameTextField(context, nameController),
              buildPadding8(),
              buildRegisterEmailTextField(context, emailController),
              buildPadding8(),
              buildRegisterPasswordTextField(
                  context, passwordController, passwordAgainController),
              buildPadding8(),
              buildRegisterButton(
                  context,
                  authService,
                  nameController,
                  emailController,
                  passwordController,
                  passwordAgainController),
            ],
          ),
        ),
      ),
    );
  }

  buildRegisterButton(
      BuildContext context,
      AuthService authService,
      TextEditingController nameController,
      TextEditingController emailController,
      TextEditingController passwordController,
      TextEditingController passwordAgainController) {
    return SizedBox(
      width: 343.0.w,
      height: 57.0.h,
      child: ElevatedButton(
        onPressed: () {
          if (passwordController.text == passwordAgainController.text) { authService
              .creatPerson(nameController.text, emailController.text,
                  passwordController.text)
              .then((value) => Navigator.pop(context));}
              else{
                 // ignore: avoid_print
                 print("Bir hata oluştu");
              }
         
        },
        child: const Text("Kayıt Ol"),
        style:
            ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
      ),
    );
  }

  buildRegisterNameTextField(
      BuildContext context, TextEditingController nameController) {
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
          controller: nameController,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0.5.sp),
              enabledBorder: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2)),
              prefixIcon: const Icon(
                Icons.account_circle,
              ),
              suffixIcon: nameController.text.isEmpty
                  ? Container(width: 0)
                  : IconButton(
                      onPressed: () {
                        nameController.clear();
                      },
                      icon: const Icon(Icons.close)),
              hintText: "Full Name"),
        ),
      ),
    );
  }

  buildRegisterEmailTextField(
      BuildContext context, TextEditingController emailController) {
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
              hintText: "Your Email"),
        ),
      ),
    );
  }

  buildRegisterPasswordTextField(
      BuildContext context,
      TextEditingController passwordController,
      TextEditingController passwordAgainController) {
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
              controller: passwordController,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0.5.sp),
                  enabledBorder: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2)),
                  prefixIcon: const Icon(
                    Icons.password,
                  ),
                  suffixIcon: passwordController.text.isEmpty
                      ? Container(width: 0)
                      : IconButton(
                          onPressed: () {
                            passwordController.clear();
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
              controller: passwordAgainController,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0.5.sp),
                  enabledBorder: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2)),
                  prefixIcon: const Icon(
                    Icons.password,
                  ),
                  suffixIcon: passwordAgainController.text.isEmpty
                      ? Container(width: 0)
                      : IconButton(
                          onPressed: () {
                            passwordAgainController.clear();
                          },
                          icon: const Icon(Icons.close)),
                  hintText: "Password Again"),
            ),
          ),
        )
      ],
    );
  }

  SizedBox buildPadding8() {
    return SizedBox(
      height: 8.0.h,
    );
  }
}
