import 'package:algitsin/core/extensions/size_extention.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}