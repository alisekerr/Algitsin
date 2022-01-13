import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:algitsin/core/extensions/size_extention.dart';

class ProductCard extends StatefulWidget {
 AsyncSnapshot snapshot;
 void Function() function;
 FaIcon faIcon;
 int index;
  ProductCard({
    Key? key,
    required this.snapshot,
    required this.function,
    required this.faIcon,
    required this.index,
  }) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
                            onTap: widget.function,
                            child: Container(
                              width: 180.0.w,
                              height: 200.0.h,
                              margin: EdgeInsets.only(
                                  right: 20.0.w, bottom: 25.0.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(5, 10),
                                    blurRadius: 15,
                                    color: Colors.grey.shade200,
                                  )
                                ],
                              ),
                              padding: EdgeInsets.all(10.0.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 100.0.h,
                                    width: 200.0.w,
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0.h),
                                              child:  CachedNetworkImage(
                                                            imageUrl: widget.snapshot
                                                                    .data!
                                                                    .docs[widget.index]
                                                                [
                                                                "productimage"][0],
                                                            fit: BoxFit.cover,
                                                            placeholder: (context,
                                                                    url) =>
                                                                Image.asset(
                                                                    "assets/basketicon.jpg"),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                Image.asset(
                                                                    "assets/erroricon.jpg"),
                                                          )),
                                        ),
                                        // Add to cart button
                                        Positioned(
                                          right: 5,
                                          bottom: 5,
                                          child: MaterialButton(
                                            color: Colors.black,
                                            minWidth: 45,
                                            height: 45,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50.0.h)),
                                            onPressed: () {},
                                            padding: EdgeInsets.all(5.0.h),
                                            child: Center(
                                                child: widget.faIcon),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0.h,
                                  ),
                                  Text(
                                    widget.snapshot.data!.docs[widget.index]["productname"],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0.spByWidth,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.snapshot.data!.docs[widget.index]
                                            ["productbrand"],
                                        style: TextStyle(
                                          color: Colors.orange.shade400,
                                          fontSize: 14.0.spByWidth,
                                        ),
                                      ),
                                      Text(
                                        " \$" +
                                            widget.snapshot.data!
                                                .docs[widget.index]["productprice"]
                                                .toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0.spByWidth,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
  }
}