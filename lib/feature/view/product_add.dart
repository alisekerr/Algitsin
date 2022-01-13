import 'dart:io';
import 'package:algitsin/feature/service/auth/auth_service.dart';
import 'package:algitsin/feature/service/firestore/firestore_service.dart';
import 'package:algitsin/feature/view/loading_page.dart';
import 'package:algitsin/product/widgets/base_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:algitsin/core/extensions/size_extention.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({Key? key}) : super(key: key);

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

TextEditingController titleController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
TextEditingController brandController = TextEditingController();
TextEditingController priceController = TextEditingController();
bool _isDiscount = false;
String _productCategory = "";
AuthService _authService = AuthService();
FirestoreService _firestoreService = FirestoreService();

class _ProductAddState extends State<ProductAdd> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedFile = [];
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  List<String> _arrImageUrl = [];

  String? boolValue;
  String? categoryValue;
  final discountItem = ["İndirimsiz Fiyat", "İndirimli Fiyat"];
  final categoryItem = ["Elektronik", "Giyim", "Ev Eşyaları"];
  bool _loadingVisible = false;

  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  DropdownMenuItem<String> buildBoolMenuItem(String item) => DropdownMenuItem(
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
    buttonImageAdd() {
      selectImage();
    }

    buttonUpload() async {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      await _changeLoadingVisible();
      await uploadFunction(_selectedFile);
      if (titleController.text == "" ||
          brandController.text == "" ||
          descriptionController.text == "" ||
          priceController.text == "" ||
          _arrImageUrl.toList().isEmpty ||
          categoryValue.toString().isEmpty) {
        onWillPop();
        await _changeLoadingVisible();
      } else {
        await _authService.creatNewProduct(
            titleController.text,
            brandController.text,
            descriptionController.text,
            _arrImageUrl.toList(),
            priceController.text,
            _isDiscount,
            categoryValue.toString());
        if (categoryValue.toString() == "Giyim") {
          await _firestoreService.categoryAddClothes(
              titleController.text,
              brandController.text,
              descriptionController.text,
              _arrImageUrl.toList(),
              priceController.text,
              _isDiscount,
              categoryValue.toString());
        }
        if (categoryValue.toString() == "Elektronik") {
          await _firestoreService.categoryAddElectronic(
              titleController.text,
              brandController.text,
              descriptionController.text,
              _arrImageUrl.toList(),
              priceController.text,
              _isDiscount,
              categoryValue.toString());
        }
        if (categoryValue.toString() == "Ev Eşyaları") {
          await _firestoreService.categoryAddHomeStuff(
              titleController.text,
              brandController.text,
              descriptionController.text,
              _arrImageUrl.toList(),
              priceController.text,
              _isDiscount,
              categoryValue.toString());
        }
        Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: buildAppBar(context),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: LoadingPage(
          inAsyncCall: _loadingVisible,
          child: Center(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _selectedFile.isEmpty
                    ? Text("No Image Selected")
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 170,
                        child: PhotoViewGallery.builder(
                          itemCount: _selectedFile.length,
                          builder: (context, index) {
                            return PhotoViewGalleryPageOptions(
                              imageProvider:
                                  FileImage(File(_selectedFile[index].path)),
                              maxScale: PhotoViewComputedScale.contained * 2,
                              minScale: PhotoViewComputedScale.contained * 0.8,
                            );
                          },
                          scrollPhysics: const BouncingScrollPhysics(),
                          backgroundDecoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor),
                        )),
                SizedBox(
                  height: 10.0.h,
                ),
                BaseButton(
                    function: buttonImageAdd,
                    icon: const FaIcon(FontAwesomeIcons.plus),
                    text: "Fotoğraf Ekle"),
                SizedBox(
                  height: 10.0.h,
                ),
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
                        hintText: "Ürün Başlığını Giriniz",
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
                        hintText: "Ürünün Markasını Giriniz",
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
                        hintText: "Ürünün Açıklamasını Giriniz",
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
                        hintText: "Ürünün Fiyatını Giriniz",
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
                      value: boolValue,
                      iconSize: 20,
                      icon: FaIcon(
                        FontAwesomeIcons.arrowDown,
                        color: Theme.of(context).selectedRowColor,
                      ),
                      items: discountItem.map(buildBoolMenuItem).toList(),
                      onChanged: (value) {
                        if (discountItem[1] == value) {
                          setState(() {
                            _isDiscount = true;
                          });
                        }
                        setState(() {
                          boolValue = value;
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
                    function: buttonUpload,
                    icon: const FaIcon(FontAwesomeIcons.plus),
                    text: "Ürünü Yükle"),
              ],
            ),
          )),
        ),
      ),
    );
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

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
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
      }
    } catch (e) {
      debugPrint("Something Wrong :" + e.toString());
    }
    setState(() {});
  }
}
