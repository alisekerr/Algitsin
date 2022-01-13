import 'package:algitsin/feature/service/firestore/product_sevice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:algitsin/core/extensions/size_extention.dart';
import 'package:algitsin/feature/service/auth/google_signin_provider.dart';
import 'package:algitsin/feature/service/firestore/firestore_service.dart';
import 'package:algitsin/feature/view/basket_page.dart';

// ignore: must_be_immutable
class ProductDetailPage extends StatefulWidget {
  List<QueryDocumentSnapshot<Object?>> selectedDoc;
  int productIndex;
  ProductDetailPage({
    Key? key,
    required this.selectedDoc,
    required this.productIndex,
  }) : super(key: key);
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

var productImageLength;
String _groupValue = "";

class _ProductDetailPageState extends State<ProductDetailPage> {
  FirestoreService firestoreService = FirestoreService();

  ProductService _productService = ProductService();
  @override
  Widget build(BuildContext context) {
    productImageLength =
        widget.selectedDoc[widget.productIndex]["productimage"].length;
    return Scaffold(
        body: StreamBuilder(
            stream: firestoreService.getAllProductData(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return SlidingUpPanel(
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(30.0.spByWidth)),
                maxHeight: 600,
                minHeight: 400,
                body: Stack(children: [
                  SizedBox(
                    width: double.maxFinite,
                    height: 350.0.h,
                    child: PhotoViewGallery.builder(
                      customSize: Size(
                        double.maxFinite,
                        350.0.h,
                      ),
                      itemCount: productImageLength,
                      builder: (context, index) {
                        return PhotoViewGalleryPageOptions(
                          filterQuality: FilterQuality.high,
                          imageProvider: NetworkImage(
                              widget.selectedDoc[widget.productIndex]
                                  ["productimage"][index]),
                          maxScale: PhotoViewComputedScale.contained * 2,
                          minScale: PhotoViewComputedScale.contained * 0.8,
                        );
                      },
                      scrollPhysics: const BouncingScrollPhysics(),
                      backgroundDecoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 20,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                  ),
                ]),
                panelBuilder: (controller) => Container(
                    width: MediaQuery.of(context).size.width,
                    height: 500.0.h,
                    decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0.spByWidth),
                            topRight: Radius.circular(30.0.spByWidth))),
                    child: Padding(
                      padding: EdgeInsets.all(16.0.spByWidth),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.selectedDoc[widget.productIndex]
                                      ["productname"],
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                        color: Colors.black87,
                                      ),
                                ),
                                Text(
                                    "\$" +
                                        widget.selectedDoc[widget.productIndex]
                                                ["productprice"]
                                            .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.normal)),
                              ],
                            ),
                            SizedBox(height: 20.0.h),
                            Text("Ürün Açıklaması",
                                style: Theme.of(context).textTheme.headline4),
                            SizedBox(
                              height: 10.0.h,
                            ),
                            Text(
                                widget.selectedDoc[widget.productIndex]
                                    ["productdescription"],
                                style: Theme.of(context).textTheme.headline3),
                            SizedBox(
                              height: 10.0.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                LikeButton(
                                  size: 30.0.spByWidth,
                                  circleColor: const CircleColor(
                                      start: Color(0xff00ddff),
                                      end: Color(0xff0099cc)),
                                  bubblesColor: const BubblesColor(
                                    dotPrimaryColor: Color(0xff33b5e5),
                                    dotSecondaryColor: Color(0xff0099cc),
                                  ),
                                  likeBuilder: (bool isLiked) {
                                    return Icon(
                                      Icons.favorite_border,
                                      color: isLiked
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey,
                                      size: 30.0.spByWidth,
                                    );
                                  },
                                  countBuilder:
                                      (int? count, bool isLiked, String text) {
                                    var color = isLiked
                                        ? Colors.deepPurpleAccent
                                        : Colors.grey;
                                    Widget result;
                                    if (count == 0) {
                                      result = Text(
                                        "",
                                        style: TextStyle(color: color),
                                      );
                                    } else {
                                      result = Text(
                                        text,
                                        style: TextStyle(color: color),
                                      );
                                    }
                                    return result;
                                  },
                                ),
                                SizedBox(
                                  height: 50.0.h,
                                  width: 150.0.w,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await _productService
                                          .basketShop(
                                              widget.selectedDoc[widget.productIndex]
                                                  ["productname"],
                                              widget.selectedDoc[widget.productIndex]
                                                  ["productbrand"],
                                              widget.selectedDoc[widget.productIndex]
                                                  ["productimage"][0],
                                              widget
                                                  .selectedDoc[widget.productIndex]
                                                      ["productprice"]
                                                  .toString(),
                                              1)
                                          .then((value) =>
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const BasketPage())));
                                      //  }
                                    },
                                    child: Text(
                                      "Sepete Ekle",
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary:
                                            Theme.of(context).primaryColor),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
              );
            }));
  }
}
