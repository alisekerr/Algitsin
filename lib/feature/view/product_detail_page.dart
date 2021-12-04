import 'package:algitsin/constants/product_key.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:algitsin/core/extensions/size_extention.dart';
import 'package:algitsin/feature/service/firestore/firestore_service.dart';
import 'package:like_button/like_button.dart';

class ProductDetailPage extends StatefulWidget {
  QueryDocumentSnapshot<Object?> selectedDoc;

  ProductDetailPage({
    Key? key,
    required this.selectedDoc,
  }) : super(key: key);
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  FirestoreService firestoreService = FirestoreService();
  String _groupValue = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: firestoreService.getClothesProductData(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return Stack(
                children: [
                  Positioned(
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        width: double.maxFinite,
                        height: 350.0.h,
                        child: Image.network(
                          widget.selectedDoc["productimage"],
                          fit: BoxFit.cover,
                        ),
                      )),
                  Positioned(
                      top: 300,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 500.0.h,
                        decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0.spByWidth),
                                topRight: Radius.circular(30.0.spByWidth))),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(16.0.spByWidth),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.selectedDoc["productname"],
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1!
                                          .copyWith(color: Colors.black87),
                                    ),
                                    Text(
                                        "\$" +
                                            widget.selectedDoc["productprice"]
                                                .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.normal)),
                                  ],
                                ),
                                /*Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      LikeButton(size: 30.0.spByWidth,),
                                    ],
                                  ),*/
                                SizedBox(height: 20.0.h),
                                ProductKey.clothes ==
                                        widget.selectedDoc.reference.parent
                                            .parent!.id
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Renk Seçenekleri",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Radio(
                                                      activeColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      value:
                                                          "${widget.selectedDoc["productcolor"][0]}",
                                                      groupValue: _groupValue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _groupValue =
                                                              value as String;
                                                        });
                                                      }),
                                                  Text(widget.selectedDoc[
                                                      "productcolor"][0])
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio(
                                                      activeColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      value:
                                                          "${widget.selectedDoc["productcolor"][1]}",
                                                      groupValue: _groupValue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _groupValue =
                                                              value as String;
                                                        });
                                                      }),
                                                  Text(widget.selectedDoc[
                                                      "productcolor"][1])
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio(
                                                      activeColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      value:
                                                          "${widget.selectedDoc["productcolor"][2]}",
                                                      groupValue: _groupValue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _groupValue =
                                                              value as String;
                                                        });
                                                      }),
                                                  Text(widget.selectedDoc[
                                                      "productcolor"][2])
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    : Container(
                                        width: 0,
                                      ),
                                Text("Ürün Açıklaması",
                                    style:
                                        Theme.of(context).textTheme.headline4),
                                Text(widget.selectedDoc["productdescription"],
                                    style:
                                        Theme.of(context).textTheme.headline3),
                                     
                        
                                /**/
                              ],
                            ),
                          ),
                        ),
                      ))
                ],
              );
            }));
  }
}
