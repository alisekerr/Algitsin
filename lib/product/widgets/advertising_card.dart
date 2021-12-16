import 'package:algitsin/core/exception/product_not_found.dart';
import 'package:algitsin/core/extensions/size_extention.dart';
import 'package:algitsin/feature/service/firestore/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdvertisingCard extends StatelessWidget {
  const AdvertisingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirestoreService firestoreService = FirestoreService();

    return SizedBox(
        height: 200.0.h,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
            stream: firestoreService.getElectronicProductData(),
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
                      return ListView.builder(
                         physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () async {},
                            child: Container(
                              width: 300.0.w,
                              margin: EdgeInsets.only(
                                  right: 20.0.w, bottom: 25.0.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0.h),
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
                                    height: 145.0.h,
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.0.h),
                                              child: Image.network(
                                                snapshot.data!.docs[index]
                                                    ["productimage"],
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                        Positioned(
                                            child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0.h),
                                              gradient: LinearGradient(
                                                  begin: Alignment.bottomCenter,
                                                  colors: [
                                                    Colors.black
                                                        .withOpacity(0.6),
                                                    Colors.black
                                                        .withOpacity(0.3),
                                                    Colors.black
                                                        .withOpacity(0.2)
                                                  ])),
                                        )),
                                        const Positioned(
                                            left: 10,
                                            bottom: 10,
                                            top: 130,
                                            child: Text(
                                              "İndirimli ürünler listeledik",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0.h,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  } else{ return const Center(child: Text("Hata..."));}
              }
            }));
  }
}

