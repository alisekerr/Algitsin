import 'package:algitsin/core/extensions/size_extention.dart';
import 'package:flutter/material.dart';

class AdvertisingCard extends StatelessWidget {
  const AdvertisingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                height: 200.0.h,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        width: 300.0.w,
                        margin: EdgeInsets.only(right: 20.0.w, bottom: 25.0.h),
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
                                        child: Image.asset(
                                            "assets/ayakkabi.png",
                                            fit: BoxFit.cover)),
                                  ),
                                  Positioned(
                                      child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0.h),
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            colors: [
                                              Colors.black.withOpacity(0.6),
                                              Colors.black.withOpacity(0.3),
                                              Colors.black.withOpacity(0.2)
                                            ])),
                                  )),
                                  const Positioned(
                                      left: 10,
                                      bottom: 10,
                                      top: 130,
                                      child: Text(
                                        "İndirimli ürünler listeledik",
                                        style: TextStyle(color: Colors.white),
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
                ),
              );
  }
}