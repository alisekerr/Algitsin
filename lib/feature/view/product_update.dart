import 'dart:io';

import 'package:algitsin/feature/service/firestore/product_sevice.dart';
import 'package:algitsin/product/widgets/base_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'package:algitsin/core/extensions/size_extention.dart';
import 'package:algitsin/feature/service/auth/auth_service.dart';
import 'package:algitsin/feature/service/firestore/firestore_service.dart';
import 'package:algitsin/feature/view/loading_page.dart';

class ProductUpdate extends StatefulWidget {
  QueryDocumentSnapshot<Object?> selectedDoc;
  ProductUpdate({
    Key? key,
    required this.selectedDoc,
  }) : super(key: key);

  @override
  State<ProductUpdate> createState() => _ProductUpdateState();
}

TextEditingController titleController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
TextEditingController brandController = TextEditingController();
TextEditingController priceController = TextEditingController();
bool _isDiscount = false;
AuthService _authService = AuthService();
ProductService _productService = ProductService();

class _ProductUpdateState extends State<ProductUpdate> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _selectedFile = [];
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final List<String> _arrImageUrl = [];
  final FirestoreService _firestoreService = FirestoreService();
  bool _loadingVisible = false;
  bool _changePhoto = false;
  String? categoryValue;
  String? value;
  final categoryItem = ["Elektronik", "Giyim", "Ev Eşyaları"];
  final discountItem = ["İndirimsiz Fiyat", "İndirimli Fiyat"];
  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );
  DropdownMenuItem<String> buildCategoryMenuItem(String item) =>
      DropdownMenuItem(
        value: item,
        child: Text(item),
      );
  @override
  Widget build(BuildContext context) {
    upgradePhotoFunction() {
      selectImage();
    }

    deleteProductFunction() async {
      await _productService
          .deleteSellerProduct(widget.selectedDoc["productname"]);
      Navigator.pop(context);
    }

    upgradeFunction() async {
      if (titleController.text == "" ||
          brandController.text == "" ||
          descriptionController.text == "" ||
          priceController.text == "" ||
          categoryValue.toString().isEmpty) {
        onWillPop();
      } else {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await _changeLoadingVisible();
        await uploadFunction(_selectedFile);
        await _productService
            .deleteSellerProduct(widget.selectedDoc["productname"]);
        await _authService.creatNewProduct(
            titleController.text,
            brandController.text,
            descriptionController.text,
            _arrImageUrl.toList(),
            priceController.text,
            _isDiscount,
            categoryValue.toString());
        Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
            padding: EdgeInsets.only(left: 16.0.spByWidth),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const FaIcon(
                FontAwesomeIcons.arrowLeft,
                color: Colors.black,
              ),
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: LoadingPage(
        inAsyncCall: _loadingVisible,
        child: Center(
            child: SingleChildScrollView(
          child: StreamBuilder(
            stream: _firestoreService.getAllSellerProductData(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 170,
                      child: _changePhoto
                          ? PhotoViewGallery.builder(
                              itemCount: _selectedFile.length,
                              builder: (context, index) {
                                return PhotoViewGalleryPageOptions(
                                  imageProvider: FileImage(
                                      File(_selectedFile[index].path)),
                                  maxScale:
                                      PhotoViewComputedScale.contained * 2,
                                  minScale:
                                      PhotoViewComputedScale.contained * 0.8,
                                );
                              },
                              scrollPhysics: const BouncingScrollPhysics(),
                              backgroundDecoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                            )
                          : Image.network(
                              widget.selectedDoc["productimage"][0])),
                  SizedBox(height: 5.0.h),
                  BaseButton(
                      function: upgradePhotoFunction,
                      icon: FaIcon(FontAwesomeIcons.photoVideo),
                      text: "Fotoğrafları Güncelle"),
                  SizedBox(height: 5.0.h),
                  SizedBox(
                    width: 343.0.w,
                    height: 48.0.h,
                    child: TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0.5.sp),
                          enabledBorder: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2)),
                          hintText: widget.selectedDoc["productname"],
                          prefixIcon: const Icon(Icons.password),
                        )),
                  ),
                  SizedBox(
                    width: 343.0.w,
                    height: 48.0.h,
                    child: TextField(
                        controller: brandController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0.5.sp),
                          enabledBorder: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2)),
                          hintText: widget.selectedDoc["productbrand"],
                          prefixIcon: const Icon(Icons.password),
                        )),
                  ),
                  SizedBox(
                    width: 343.0.w,
                    height: 48.0.h,
                    child: TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0.5.sp),
                          enabledBorder: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2)),
                          hintText: widget.selectedDoc["productdescription"],
                          prefixIcon: const Icon(Icons.password),
                        )),
                  ),
                  SizedBox(
                    width: 343.0.w,
                    height: 48.0.h,
                    child: TextField(
                        controller: priceController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0.5.sp),
                          enabledBorder: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2)),
                          hintText: widget.selectedDoc["productprice"],
                          prefixIcon: const Icon(Icons.password),
                        )),
                  ),
                  Container(
                    width: 330.0.w,
                    height: 48.0.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButton<String>(
                        hint: Text("Ürünün Fiyat Durumu",
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: Colors.grey)),
                        isExpanded: true,
                        value: value,
                        iconSize: 20,
                        icon: FaIcon(
                          FontAwesomeIcons.arrowDown,
                          color: Theme.of(context).selectedRowColor,
                        ),
                        items: discountItem.map(buildMenuItem).toList(),
                        onChanged: (value) {
                          if (discountItem[1] == value) {
                            setState(() {
                              _isDiscount = true;
                            });
                          }
                          setState(() {
                            this.value = value;
                          });
                        }),
                  ),
                  Container(
                    width: 330.0.w,
                    height: 48.0.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButton<String>(
                        hint: Text("Ürünün Kategorisini Seçiniz",
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: Colors.grey)),
                        isExpanded: true,
                        value: categoryValue,
                        iconSize: 20,
                        icon: FaIcon(
                          FontAwesomeIcons.arrowDown,
                          color: Theme.of(context).selectedRowColor,
                        ),
                        items: categoryItem.map(buildCategoryMenuItem).toList(),
                        onChanged: (value) {
                          setState(() {
                            categoryValue = value;
                          });
                        }),
                  ),
                  BaseButton(
                      function: upgradeFunction,
                      icon: const FaIcon(FontAwesomeIcons.upload),
                      text: "Ürünü Güncelle"),
                  SizedBox(height: 5.0.h),
                  BaseButton(
                      function: deleteProductFunction,
                      icon: const FaIcon(FontAwesomeIcons.trash),
                      text: "Ürünü Kaldır"),
                ],
              );
            },
          ),
        )),
      ),
    );
  }

  Future<void> uploadFunction(List<XFile> _image) async {
    for (var i = 0; i < _image.length; i++) {
      var imageUrl = await uploadFile(_image[i]);
      _arrImageUrl.add(imageUrl.toString());
    }
  }

  Future<String> uploadFile(XFile _image) async {
    Reference reference =
        _firebaseStorage.ref().child("multiple_image").child(_image.name);
    UploadTask uploadTask = reference.putFile(File(_image.path));
    await uploadTask.whenComplete(() => print(reference.getDownloadURL()));
    return await reference.getDownloadURL();
  }

  Future<void> selectImage() async {
    if (_selectedFile != null) {
      _selectedFile.clear();
    }
    try {
      final List<XFile>? imgs = await _picker.pickMultiImage();
      if (imgs!.isNotEmpty) {
        _selectedFile.addAll(imgs);
        setState(() {
          _changePhoto = true;
        });
        print("Listeye eklendi ");
      }
      print("List of Selected İmage : " + imgs.length.toString());
    } catch (e) {
      print("Something Wrong :" + e.toString());
    }
    setState(() {});
  }

  Future<bool> onWillPop() async {
    final shouldPop = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("HATA"),
              content: const Text("Lütfen İstenen Bilgileri Giriniz"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text("Tamam"))
              ],
            ));
    return shouldPop ?? false;
  }
}
