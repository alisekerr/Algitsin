import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSigninProvider extends ChangeNotifier {
  final googleSignin = GoogleSignIn();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final userGoogle = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool deneme = true;
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  Future googleLogin() async {
    GoogleSignInAccount? googleUser;
    try {
      googleUser = await googleSignin.signIn().catchError((e) => e.toString());
    } catch (e) {
      print("9 error " + e.toString());
    }

    if (googleUser == null) {
      return deneme;
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

  Future creatPerson(String name, String email, bool isSeller) async {
    await firestore
        .collection("Person")
        .doc(userGoogle!.uid)
        .set({"username": name, "email": email, "isseller": isSeller});
  }

  
}
