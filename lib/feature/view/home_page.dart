import 'package:algitsin/core/exception/product_not_found.dart';
import 'package:algitsin/core/extensions/size_extention.dart';
import 'package:algitsin/feature/service/firestore/firestore_service.dart';
import 'package:algitsin/feature/view/product_detail_page.dart';
import 'package:algitsin/product/widgets/advertising_card.dart';
import 'package:algitsin/product/widgets/product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    FirestoreService firestoreService = FirestoreService();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AdvertisingCard(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Text(
                "Haftanın Ürünleri",
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w),
              child: SizedBox(
                  height: 200.0.h,
                  child: StreamBuilder(
                      stream: firestoreService.getAllProductData(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            throw ProductNotFound(
                                value: snapshot.data!.docs.toString());
                          case ConnectionState.waiting:
                            return const Center(
                                child: Text("Ürün Yükleniyor..."));
                          default:
                            if (snapshot.hasData) {
                              if (snapshot.data!.docs.isEmpty) {
                                return const Center(
                                    child: Text("Ürün Bulunamadı..."));
                              } else {
                                return ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    weekProductCard() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetailPage(
                                                    selectedDoc:
                                                        snapshot.data!.docs,
                                                    productIndex: index,
                                                  )));
                                    }

                                    return snapshot.data!.docs[index]
                                            ["productdiscount"]
                                        ? ProductCard(
                                            snapshot: snapshot,
                                            function: weekProductCard,
                                            faIcon: const FaIcon(
                                              FontAwesomeIcons.shoppingBasket,
                                              color: Colors.white,
                                            ),
                                            index: index)
                                        : Container();
                                  },
                                );
                              }
                            } else {
                              return const Center(child: Text("Hata..."));
                            }
                        }
                      })),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Text(
                "İndirimlerde En Çok Tercih Edilenler",
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            StreamBuilder(
                stream: firestoreService.getClothesProductData(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      throw ProductNotFound(
                          value: snapshot.data!.docs.toString());
                    case ConnectionState.waiting:
                      return const Center(child: Text("Ürün Yükleniyor..."));
                    default:
                      if (snapshot.hasData) {
                        if (snapshot.data!.docs.isEmpty) {
                          return const Center(
                              child: Text("Ürün Bulunamadı..."));
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
                              clothesCard() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDetailPage(
                                              selectedDoc: snapshot.data!.docs,
                                              productIndex: index,
                                            )));
                              }

                              return ProductCard(
                                  snapshot: snapshot,
                                  function: clothesCard,
                                  faIcon: const FaIcon(
                                    FontAwesomeIcons.shoppingBasket,
                                    color: Colors.white,
                                  ),
                                  index: index);
                            },
                          );
                        }
                      } else {
                        return const Center(child: Text("Hata..."));
                      }
                  }
                })
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 40.0.h,
              child: TextField(
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.0.w, vertical: 10.0.w),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search,
                      color: Theme.of(context).selectedRowColor),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0.h),
                      borderSide: BorderSide.none),
                  hintText: "Marka, ürün veya kategori ara",
                  hintStyle: TextStyle(
                      fontSize: 10.0.spByWidth,
                      color: Theme.of(context).selectedRowColor),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0.w),
          Container(
            height: 40.0.h,
            width: 40.0.w,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0.h)),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.filter_list,
                color: Theme.of(context).selectedRowColor,
                size: 20.0.h,
              ),
            ),
          )
        ],
      ),
    );
  }
}
