import 'package:algitsin/core/extensions/size_extention.dart';
import 'package:algitsin/product/widgets/advertising_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
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
        ),
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
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 180.0.w,
                          height: 180.0.h,
                          margin:
                              EdgeInsets.only(right: 20.0.w, bottom: 25.0.w),
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
                                          child: Image.asset(
                                              "assets/ayakkabi.png",
                                              fit: BoxFit.cover)),
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
                                                BorderRadius.circular(50.0.h)),
                                        onPressed: () {},
                                        padding: EdgeInsets.all(5.0.h),
                                        child: Center(
                                            child: Icon(
                                          Icons.shopping_cart,
                                          color: Colors.white,
                                          size: 19.0.h,
                                        )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.0.h,
                              ),
                              Text(
                                "Nike 2021 Defy All Day",
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
                                    "Nike",
                                    style: TextStyle(
                                      color: Colors.orange.shade400,
                                      fontSize: 14.0.spByWidth,
                                    ),
                                  ),
                                  Text(
                                    " \$50",
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
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: Text(
                  "İndirimlerde En Çok Tercih Edilenler",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              StaggeredGridView.countBuilder(
                staggeredTileBuilder: (index)=>const StaggeredTile.count(1, 1.3),
                shrinkWrap: true,
                physics:  const NeverScrollableScrollPhysics(),
              
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                   return GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 180.0.w,
                          height: 200.0.h,
                          margin:
                              EdgeInsets.only(right: 20.0.w, bottom: 25.0.w),
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
                                          child: Image.asset(
                                              "assets/ayakkabi.png",
                                              fit: BoxFit.cover)),
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
                                                BorderRadius.circular(50.0.h)),
                                        onPressed: () {},
                                        padding: EdgeInsets.all(5.0.h),
                                        child: Center(
                                            child: Icon(
                                          Icons.shopping_cart,
                                          color: Colors.white,
                                          size: 19.0.h,
                                        )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.0.h,
                              ),
                              Text(
                                "Nike 2021 Defy All Day",
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
                                    "Nike",
                                    style: TextStyle(
                                      color: Colors.orange.shade400,
                                      fontSize: 14.0.spByWidth,
                                    ),
                                  ),
                                  Text(
                                    " \$50",
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
                },
              ),
                
            ],
          ),
        ),
      ),
    );
  }
}
