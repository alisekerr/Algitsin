import 'package:algitsin/core/extensions/size_extention.dart';
import 'package:algitsin/feature/service/auth/google_signin_provider.dart';
import 'package:algitsin/feature/view/control_page.dart';
import 'package:algitsin/feature/view/login_page.dart';
import 'package:algitsin/feature/view/seller_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GoogleLanding extends StatefulWidget {
  const GoogleLanding({Key? key}) : super(key: key);

  @override
  State<GoogleLanding> createState() => _GoogleLandingState();
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
CollectionReference personRef = firestore.collection("Person");
var docRef = personRef.doc(firebaseAuth.currentUser!.uid.toString());
final FirebaseFirestore firestore = FirebaseFirestore.instance;
User? user = FirebaseAuth.instance.currentUser;
GoogleSigninProvider googleSignin = GoogleSigninProvider();

Future<bool> isSeller() async {
  DocumentSnapshot data = await docRef.get();
  return data["isseller"];
}

class _GoogleLandingState extends State<GoogleLanding> {
  @override
  Widget build(BuildContext context) {
    googleSignin.creatPerson(user!.displayName!, user!.email!,false);
    return FutureBuilder<bool>(
        future: isSeller(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!) {
              return SellerPage();
            } else {
              return const ControlPage();
            }
          } else {
            return Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: SpinKitWave(
                color: Theme.of(context).primaryColor,
                size: 30.0.spByWidth,
              ),
            );
          }
        });
  }
}
