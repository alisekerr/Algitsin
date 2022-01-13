import 'dart:io';

import 'package:algitsin/feature/service/firestore/i_product_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductService extends IProductService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future basketShop(String name, String brand, String imageUrl, String price,int productCount) async {
      await firestore
        .collection("Person")
        .doc(user!.uid)
        .collection("Product")
        .doc(name)
        .set({
      "productname": name,
      "productbrand": brand,
      "productprice": price,
      "productimage": imageUrl,
      "productcount":productCount,
    });
  }
deleteSellerProduct(
    String name,
  ) async {
    await firestore
        .collection("Person")
        .doc(auth.currentUser!.uid)
        .collection("SellerProduct")
        .doc(name)
        .delete();
    await firestore.collection("ProductGlobal").doc(name).delete();
  }
  deleteProduct(
    String name,
  ) async {
    await firestore
        .collection("Person")
        .doc(auth.currentUser!.uid)
        .collection("Product")
        .doc(name)
        .delete();
   
  }

  @override
  Future<String> uploadMedia(File file) async {
     var storageTef;
    UploadTask uploadTask = _firebaseStorage
        .ref()
        .child(
            "${DateTime.now().microsecondsSinceEpoch}.${file.path.split(".").last}")
        .putFile(file);

        uploadTask.snapshotEvents.listen((event) { });
       
        await uploadTask.then((value) => storageTef=value);
        return await storageTef.ref.getDownloadURL;
}

}