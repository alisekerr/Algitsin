import 'package:algitsin/constants/product_key.dart';
import 'package:algitsin/feature/service/firestore/i_firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FirestoreService extends IFirebaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Stream<QuerySnapshot> getElectronicProductData() {
    var reference = firestore
        .collection("Category")
        .doc(ProductKey.electronic)
        .collection("Product")
        .snapshots();

    return reference;
  }

  @override
  Stream<QuerySnapshot<Object?>> getClothesProductData() {
    var reference = firestore
        .collection("Category")
        .doc(ProductKey.clothes)
        .collection("Product")
        .snapshots();

    return reference;
  }

  @override
  Stream<QuerySnapshot<Object?>> getHomeStuffProductData() {
   var reference = firestore
        .collection("Category")
        .doc(ProductKey.homeStuff)
        .collection("Product")
        .snapshots();

    return reference;
  }

}
