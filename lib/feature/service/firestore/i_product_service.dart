import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IProductService{


 Future basketShop(String name, String brand, String imageUrl, String price,int productCount) ;
  Future<String> uploadMedia(File file);

  
}