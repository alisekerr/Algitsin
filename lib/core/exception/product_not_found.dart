class ProductNotFound implements Exception {
  final String value;
  ProductNotFound({
    required this.value,
  });
  
@override
  String toString() {
  
    return "This  $value doesnt found in database" ;
  }

}
