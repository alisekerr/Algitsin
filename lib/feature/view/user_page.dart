import 'package:algitsin/core/extensions/size_extention.dart';
import 'package:algitsin/feature/service/auth/auth_service.dart';
import 'package:algitsin/feature/service/auth/google_signin_provider.dart';
import 'package:algitsin/feature/view/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

final FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference personRef = firestore.collection("Person");
String? userId;

class _UserPageState extends State<UserPage> {
  final userId = FirebaseAuth.instance.currentUser!.uid.toString();
  var docRef = personRef.doc(FirebaseAuth.instance.currentUser!.uid.toString());
  final AuthService _authService = AuthService();
  Future<String> fetchName() async {
    DocumentSnapshot data = await docRef.get();
    return data["username"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          FutureBuilder<String>(
              future: fetchName(),
              builder: (context, AsyncSnapshot<String> snapshot) {
                return Container(
                  height: 100.0.h,
                  width: double.maxFinite,
                  color: Theme.of(context).primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Merhaba",
                            style: Theme.of(context).textTheme.overline,
                          ),
                          Text(
                            snapshot.data.toString(),
                            style: Theme.of(context).textTheme.overline,
                          )
                        ],
                      ),
                      Image.asset("assets/welcome-icon.png")
                    ],
                  ),
                );
              }),
          SizedBox(
              height: 50.0.h,
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {},
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const FaIcon(FontAwesomeIcons.viber,
                              color: Colors.black),
                          SizedBox(width: 5.0.w),
                          Text("Hesap Bilgilerim",
                              style: Theme.of(context).textTheme.subtitle1),
                        ],
                      ),
                    ]),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).canvasColor),
              )),
          SizedBox(
              height: 50.0.h,
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {},
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const FaIcon(FontAwesomeIcons.boxOpen,
                              color: Colors.black),
                          SizedBox(width: 5.0.w),
                          Text("Siparişlerim",
                              style: Theme.of(context).textTheme.subtitle1),
                        ],
                      ),
                    ]),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).canvasColor),
              )),
          SizedBox(
              height: 50.0.h,
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {},
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const FaIcon(FontAwesomeIcons.envelopeOpenText,
                              color: Colors.black),
                          SizedBox(width: 5.0.w),
                          Text("Değerlendirmelerim",
                              style: Theme.of(context).textTheme.subtitle1),
                        ],
                      ),
                    ]),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).canvasColor),
              )),
          SizedBox(
              height: 50.0.h,
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {},
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const FaIcon(FontAwesomeIcons.wallet,
                              color: Colors.black),
                          SizedBox(width: 5.0.w),
                          Text("Cüzdanım",
                              style: Theme.of(context).textTheme.subtitle1),
                        ],
                      ),
                    ]),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).canvasColor),
              )),
          SizedBox(
              height: 50.0.h,
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {},
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const FaIcon(FontAwesomeIcons.streetView,
                              color: Colors.black),
                          SizedBox(width: 5.0.w),
                          Text("Yardım",
                              style: Theme.of(context).textTheme.subtitle1),
                        ],
                      ),
                    ]),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).canvasColor),
              )),
          SizedBox(
              height: 50.0.h,
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {
                  _authService.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (route) => false);
                  final provider =
                      Provider.of<GoogleSigninProvider>(context, listen: false);
                  provider.googleOut().then((value) =>
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                          (route) => false));
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const FaIcon(FontAwesomeIcons.signOutAlt,
                              color: Colors.black),
                          SizedBox(width: 5.0.w),
                          Text("Çıkış Yap",
                              style: Theme.of(context).textTheme.subtitle1),
                        ],
                      ),
                    ]),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).canvasColor),
              )),
        ],
      ),
    )
        /*StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
         if (snapshot.connectionState==ConnectionState.waiting) {
           return const Center(child: CircularProgressIndicator(),);
         }else if(snapshot.hasData){
           return const LoggedinWidget();
         }
         else if(snapshot.hasError){
           return const Center(child: Text("Error...."));
         }
         else{
            return const Text("Try Again...");
         }
        },
      ),*/
        );
  }
}
