import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:algitsin/feature/service/auth/i_auth_service.dart';

class AuthService extends IAuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<User?> signIn(String email, String password) async {
    var user =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    return user.user;
  }

  @override
  signOut() async {
    await auth.signOut();
  }

  @override
  Future<User?> creatPerson(
      String name, String email, String password, bool isSeller) async {
    var user = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await firestore
        .collection("Person")
        .doc(user.user!.uid)
        .set({"username": name, "email": email, "isseller": isSeller});

    return user.user;
  }

  creatNewProduct(String name, String brand, String description, List imageUrl,
      String price, bool discount, String category) async {
    await firestore
        .collection("Person")
        .doc(auth.currentUser!.uid)
        .collection("SellerProduct")
        .doc(name)
        .set({
      "productname": name,
      "productbrand": brand,
      "productdescription": description,
      "productprice": price,
      "productimage": imageUrl,
      "productdiscount": discount,
      "productcategory": category
    });
    await firestore.collection("ProductGlobal").doc(name).set({
      "productname": name,
      "productbrand": brand,
      "productdescription": description,
      "productprice": price,
      "productimage": imageUrl,
      "productdiscount": discount,
      "productcategory": category
    });
  }

  
}
