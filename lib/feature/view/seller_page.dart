import 'package:algitsin/core/exception/product_not_found.dart';
import 'package:algitsin/feature/service/auth/auth_service.dart';
import 'package:algitsin/feature/service/firestore/firestore_service.dart';
import 'package:algitsin/feature/view/login_page.dart';
import 'package:algitsin/feature/view/product_add.dart';
import 'package:algitsin/feature/view/product_update.dart';
import 'package:algitsin/product/widgets/product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SellerPage extends StatefulWidget {
  const SellerPage({Key? key}) : super(key: key);

  @override
  State<SellerPage> createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  FirestoreService firestoreService = FirestoreService();
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
            stream: firestoreService.getAllSellerProductData(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  throw ProductNotFound(value: snapshot.data!.docs.toString());
                case ConnectionState.waiting:
                  return const Center(child: Text("Ürün Yükleniyor..."));
                default:
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text("Ürün Bulunamadı..."));
                    } else {
                      return StaggeredGridView.countBuilder(
                        staggeredTileBuilder: (index) =>
                            const StaggeredTile.count(1, 1.3),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          cardFunction() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductUpdate(
                                        selectedDoc:
                                            snapshot.data!.docs[index])));
                          }

                          return ProductCard(
                            snapshot: snapshot,
                            faIcon: const FaIcon(FontAwesomeIcons.arrowRight,color: Colors.white,),
                            index: index,
                            function: cardFunction,
                          );
                        },
                      );
                    }
                  } else {
                    return const Center(child: Text("Hata..."));
                  }
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const FaIcon(FontAwesomeIcons.plus),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProductAdd()));
        },
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      actions: [
        IconButton(
            onPressed: () {
              _authService.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false);
            },
            icon: const FaIcon(
              FontAwesomeIcons.signOutAlt,
              color: Colors.black,
            ))
      ],
      title: Text(
        "Satıştaki Ürünlerim",
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }
}
