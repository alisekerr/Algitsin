import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSigninProvider extends ChangeNotifier {
  final googleSignin = GoogleSignIn();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final userGoogle = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  Future googleLogin() async {
    final googleUser = await googleSignin.signIn();
    if (googleUser == null) {
      return _user = googleUser;
    }
    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future googleOut() async {
    await googleSignin.disconnect();
    FirebaseAuth.instance.signOut();
  }

  Future creatPerson(String name, String email) async {
    await firestore
        .collection("Person")
        .doc(userGoogle!.uid)
        .set({"username": name, "email": email});
  }

  Future basketShop(
      String name, String brand, String imageUrl, int price) async {
    await firestore
        .collection("Person")
        .doc(userGoogle!.uid)
        .collection("Product")
        .doc(name)
        .set({
      "Productcount": 1,
      "productname": name,
      "productbrand": brand,
      "productprice": price,
      "productimage": imageUrl,
    });
  }
}
