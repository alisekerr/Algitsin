import 'package:algitsin/core/exception/product_not_found.dart';
import 'package:algitsin/core/extensions/size_extention.dart';
import 'package:algitsin/feature/view/control_page.dart';
import 'package:algitsin/product/manager/basket_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:count_stepper/count_stepper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({Key? key}) : super(key: key);

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  @override
  Widget build(BuildContext context) {
    BasketManager basketManager = BasketManager();
    num totalPrice = 0;
    bool isNullBasket = true;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ControlPage()),
                    (route) => false);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          title: Text(
            "SEPETİM",
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(fontSize: 20.0.sp),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder(
                stream: basketManager.getAllBasketProduct(),
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
                          isNullBasket = false;
                          return Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Ürün Bulunamadı...",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              SizedBox(
                                height: 50.0.h,
                                width: 150.0.w,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ControlPage()));
                                  },
                                  child: Text(
                                    "Alışverişe Dön",
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary:
                                          Theme.of(context).primaryColor),
                                ),
                              )
                            ],
                          ));
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 180.0.w,
                                  height: 170.0.h,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height: 100.0.h,
                                            width: 150.0.w,
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0.h),
                                                  child: Image.network(
                                                      snapshot.data!.docs[index]
                                                          ["productimage"],
                                                      fit: BoxFit.cover)),
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                " \$" +
                                                    snapshot
                                                        .data!
                                                        .docs[index]
                                                            ["productprice"]
                                                        .toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.0.spByWidth,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                              /* CountStepper(
                                                iconColor: Theme.of(context)
                                                    .primaryColor,
                                                defaultValue: 1,
                                                max: 10,
                                                min: 1,
                                                iconDecrementColor:
                                                    Theme.of(context).cardColor,
                                                splashRadius: 12,
                                                onPressed: (value) {
                                                  valuee = value;
                                                  debugPrint(valuee.toString());
                                                },
                                              ),*/
                                              Row(
                                                children: [
                                                  IconButton(
                                                      onPressed: () {
                                                        if (snapshot.data!
                                                                    .docs[index]
                                                                [
                                                                "productcount"] >
                                                            1) {
                                                          snapshot.data!.docs[
                                                                      index][
                                                                  "productcount"] -
                                                              1;
                                                        }
                                                      },
                                                      icon: FaIcon(
                                                        FontAwesomeIcons
                                                            .minusCircle,
                                                        color: Theme.of(context)
                                                            .cardColor,
                                                        size: 20,
                                                      )),
                                                  Text(
                                                    "value[index].toString()",
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                  ),
                                                  SizedBox(
                                                    child: IconButton(
                                                        onPressed: () {},
                                                        icon: FaIcon(
                                                          FontAwesomeIcons
                                                              .plusCircle,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          size: 20,
                                                        )),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]
                                            ["productname"],
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .selectedRowColor,
                                          fontSize: 12.0.spByWidth,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]
                                            ["productbrand"],
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 14.0.spByWidth,
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
                      } else {
                        return const Center(child: Text("Hata..."));
                      }
                  }
                }),
             StreamBuilder(
                    stream: basketManager.getAllBasketProduct(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        for (var i = 0; i < snapshot.data!.docs.length; i++) {
                          //  totalPrice = value[i] * snapshot.data!.docs[i]["productprice"];
                        }
                        debugPrint("Toplam para : $totalPrice");
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Toplam Fiyat : $totalPrice\$",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          SizedBox(
                            height: 50.0.h,
                            width: 150.0.w,
                            child: Padding(
                              padding: EdgeInsets.all(3.0.spByWidth),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  "Sepeti Onayla",
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                
          ],
        ));
  }
}
