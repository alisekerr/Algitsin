import 'package:algitsin/core/extensions/size_extention.dart';
import 'package:algitsin/feature/service/auth/auth_service.dart';
import 'package:algitsin/feature/view/loading_page.dart';
import 'package:algitsin/feature/view/login_page.dart';
import 'package:algitsin/product/widgets/base_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _loadingVisible = false;
  bool isSeller = false;
  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }
    bool _isVisibility=false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordAgainController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var theme = Theme.of(context).textTheme;
    AuthService authService = AuthService();
    buttonRegister() async {
      if (nameController.text ==""||emailController.text ==""||passwordController.text ==""||passwordAgainController.text =="") {
        setState(() {
          _isVisibility=true;
        });

      }
      else{if (passwordController.text == passwordAgainController.text) {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await _changeLoadingVisible();
        authService
            .creatPerson(nameController.text, emailController.text,
                passwordController.text, isSeller)
            .then((value) => Navigator.pop(context));
      }}
      
    }

    return Scaffold(
      appBar: buildAppBar(context),
      body: LoadingPage(
        inAsyncCall: _loadingVisible,
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
                  buildRegisterNameTextField(context, nameController),
                  buildPadding8(),
                  buildRegisterEmailTextField(context, emailController),
                  buildPadding8(),
                  buildRegisterPasswordTextField(
                      context, passwordController, passwordAgainController),
                  buildPadding8(),
                  buildSellerSwitch(theme, context),
                  buildPadding8(),
                  BaseButton(function: buttonRegister, icon: const FaIcon(FontAwesomeIcons.user), text: "Kayıt Ol"),
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
      ),
    );
  }

  Row buildSellerSwitch(TextTheme theme, BuildContext context) {
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
                isSeller = value;
              });
            }),
      ],
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: Padding(
          padding: EdgeInsets.only(left: 16.0.spByWidth),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: Theme.of(context).selectedRowColor,
            ),
          )),
      backgroundColor: Colors.transparent,
      elevation: 0,
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
