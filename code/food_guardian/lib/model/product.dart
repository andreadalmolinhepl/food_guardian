import 'package:food_guardian/model/allergen.dart';

import 'nutritional_info_monitored.dart';
import 'nutritional_preference.dart';

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
  final List<NutritionalPreference> nutritionalPreferences;
  final String ingredientsText;
  final String nutriscoreGrade;
  final String productName;
  final String brand;
  final String traces;
  final String imageUrl;

  ProductDetails({
    required this.allergens,
    required this.nutritionalPreferences,
    required this.ingredientsText,
    required this.nutriscoreGrade,
    required this.productName,
    required this.brand,
    required this.traces,
    required this.imageUrl,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    List<Allergen> allergensList = [];
    if (json['allergens'] != null && (json['allergens'] as String).isNotEmpty) {
      List<String> allergenNames = (json['allergens'] as String).split(',');
      allergensList = allergenNames.map((name) {
        String transformedName = name.substring(3).toLowerCase();
        transformedName = transformedName[0].toUpperCase() + transformedName.substring(1);
        return Allergen(name: transformedName);
      }).toList();
    } else {
      allergensList = List.empty();
    }

    List<NutritionalPreference> nutritionalPrefs = [];

    if (json['ingredients_analysis_tags'] != null) {
      List<String> ingredientsTags = List<String>.from(json['ingredients_analysis_tags']);

      nutritionalPrefs = ingredientsTags.where((tag) {
        return NutritionalInfoMonitored.values.any((value) {
          String enumName = value.toString().split('.').last;
          return tag.toLowerCase().contains(enumName.toLowerCase());
        });
      }).map((tag) {
        NutritionalInfoMonitored? matchedEnum = NutritionalInfoMonitored.values.firstWhere((value) {
          String enumName = value.stringValue;
          return tag.toLowerCase().contains(enumName.toLowerCase());
        });

        String status = 'Unknown';

        if (tag.contains('unknown')) {
          status = 'Unknown';
        } else if (tag.contains('may')) {
          status = 'May';
        } else if (tag.contains('non')) {
          status = 'No';
        } else {
          status = 'Yes';
        }

        String modifiedTag = matchedEnum.stringValue;

        return NutritionalPreference(name: modifiedTag, status: status);
      }).toList();
    }

    return ProductDetails(
      allergens: allergensList,
      nutritionalPreferences: nutritionalPrefs,
      ingredientsText: json['ingredients_text'] ?? '',
      nutriscoreGrade: json['nutriscore_grade'] ?? '',
      productName: json['product_name'] ?? '',
      brand: json['brands'] ?? '',
      traces: json['traces'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }
}

class ProductSnippet {
  final String id;
  final String productName;
  final String brand;
  final String imageUrl;
  final String nutriscore;

  ProductSnippet({
    required this.id,
    required this.productName,
    required this.brand,
    required this.imageUrl,
    required this.nutriscore,
  });

  factory ProductSnippet.fromMap(String id, Map<String, dynamic> map) {
    return ProductSnippet(
      id: map['id'] ?? '',
      productName: map['productName'] ?? '',
      brand: map['productBrand'] ?? '',
      imageUrl: map['image'] ?? '',
      nutriscore: map['nutriscore'] ?? '',
    );
  }
}