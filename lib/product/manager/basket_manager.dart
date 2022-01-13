import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class BasketManager {
   FirebaseFirestore firestore = FirebaseFirestore.instance;
       final user = FirebaseAuth.instance.currentUser!;
 Stream<QuerySnapshot> getAllBasketProduct() {
    var reference = firestore
        .collection("Person")
        .doc(user.uid)
        .collection("Product")
        .snapshots();

    return reference;
  }
}