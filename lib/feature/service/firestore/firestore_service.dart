import 'package:algitsin/constants/product_key.dart';
import 'package:algitsin/feature/service/firestore/i_firestore_service.dart';
import 'package:algitsin/feature/view/landing_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService extends IFirebaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
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

  @override
  Stream<QuerySnapshot<Object?>> getAllProductData() {
    var reference = firestore.collection("ProductGlobal").snapshots();

    return reference;
  }
    @override
  Stream<QuerySnapshot<Object?>> getAllSellerProductData() {
    var reference = firestore
        .collection("Person")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("SellerProduct")
        .snapshots();

    return reference;
  }

    Future categoryAddClothes( String name,
    String brand,
    String description,
    List imageUrl,
    String price,
    bool discount,
    String category) async {
    await firestore
        .collection("Category")
        .doc(ProductKey.clothes)
        .collection("Product")
        .doc(name)
        .set({
        "productname": name,
      "productbrand": brand,
      "productdescription":description,
      "productprice": price,
      "productimage": imageUrl,
      "productdiscount":discount,
      "productcategory":category
    });
  }
  Future categoryAddElectronic( String name,
    String brand,
    String description,
    List imageUrl,
    String price,
    bool discount,
    String category) async {
    await firestore
        .collection("Category")
        .doc(ProductKey.electronic)
        .collection("Product")
        .doc(name)
        .set({
       "productname": name,
      "productbrand": brand,
       "productdescription":description,
      "productprice": price,
      "productimage": imageUrl,
      "productdiscount":discount,
      "productcategory":category
    });
  }
  Future categoryAddHomeStuff( String name,
    String brand,
    String description,
    List imageUrl,
    String price,
    bool discount,
    String category) async {
    await firestore
        .collection("Category")
        .doc(ProductKey.homeStuff)
        .collection("Product")
        .doc(name)
        .set({
       "productname": name,
      "productbrand": brand,
       "productdescription":description,
      "productprice": price,
      "productimage": imageUrl,
      "productdiscount":discount,
      "productcategory":category
    });
  }
}
