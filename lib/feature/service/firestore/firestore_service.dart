import 'package:algitsin/feature/service/firestore/i_firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FirestoreService extends IFirebaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Stream<QuerySnapshot> getElectronicProductData() {
    var reference = firestore
        .collection("Category")
        .doc("3Zv9gK44V8kKrGcHTO9N")
        .collection("Product")
        .snapshots();

    return reference;
  }

  @override
  Stream<QuerySnapshot<Object?>> getClothesProductData() {
    var reference = firestore
        .collection("Category")
        .doc("tbJzAyswVuIUhzbGJBDa")
        .collection("Product")
        .snapshots();

    return reference;
  }

  @override
  Stream<QuerySnapshot<Object?>> getHomeStuffProductData() {
   var reference = firestore
        .collection("Category")
        .doc("zbXNdXJP9NOZXDRZIi4n")
        .collection("Product")
        .snapshots();

    return reference;
  }
}
