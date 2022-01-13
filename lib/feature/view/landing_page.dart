import 'package:algitsin/core/extensions/size_extention.dart';
import 'package:algitsin/feature/view/control_page.dart';
import 'package:algitsin/feature/view/login_page.dart';
import 'package:algitsin/feature/view/seller_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
CollectionReference personRef = firestore.collection("Person");
var docRef = personRef.doc(firebaseAuth.currentUser!.uid.toString());
final FirebaseFirestore firestore = FirebaseFirestore.instance;


Future<bool> isSeller() async {
  DocumentSnapshot data = await docRef.get();
  return data["isseller"];
}

class _LandingPageState extends State<LandingPage> {
  bool userGoogle=true;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: isSeller(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!) {
              return  const SellerPage();
            } else {
              return const ControlPage();
            }
          } else {
            return buidlLoading(context);
          }
        });
  }

  Container buidlLoading(BuildContext context) {
    return Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: SpinKitWave(
            color: Theme.of(context).primaryColor,
            size: 30.0.spByWidth,
          ),
          );
  }
}
