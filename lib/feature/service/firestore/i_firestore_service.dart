import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IFirebaseService{
 Stream<QuerySnapshot> getElectronicProductData ();
Stream<QuerySnapshot> getClothesProductData ();
Stream<QuerySnapshot> getHomeStuffProductData ();
  
}