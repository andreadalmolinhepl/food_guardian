import 'package:food_guardian/model/allergen.dart';

class Product {
  final String code;
  final ProductDetails product;
  final int status;
  final String statusVerbose;

  Product({
    required this.code,
    required this.product,
    required this.status,
    required this.statusVerbose,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      code: json['code'] ?? '',
      product: ProductDetails.fromJson(json['product']),
      status: json['status'] ?? 0,
      statusVerbose: json['status_verbose'] ?? '',
    );
  }
}

class ProductDetails {
  final List<Allergen> allergens;
  final String ingredientsText;
  final String nutriscoreGrade;
  final String productName;
  final String brand;
  final String traces;
  final String imageUrl;

  ProductDetails({
    required this.allergens,
    required this.ingredientsText,
    required this.nutriscoreGrade,
    required this.productName,
    required this.brand,
    required this.traces,
    required this.imageUrl,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    List<Allergen> allergensList = [];
    if (json['allergens'] != null) {
      List<String> allergenNames = (json['allergens'] as String).split(',');
      allergensList = allergenNames.map((name) => Allergen(name: name)).toList();
    }

    return ProductDetails(
      allergens: allergensList,
      ingredientsText: json['ingredients_text'] ?? '',
      nutriscoreGrade: json['nutriscore_grade'] ?? '',
      productName: json['product_name'] ?? '',
      brand: json['brands'] ?? '',
      traces: json['traces'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }
}
