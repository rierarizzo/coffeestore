import 'dart:convert';

import 'package:coffee_store/models/product.dart';
import 'package:coffee_store/models/productcategory.dart';
import 'package:http/http.dart';

class ProductService {
  final client = Client();
  final uri = "http://localhost:8080/products";

  Future<List<Product>> getProducts({String? categoryFilter}) async {
    String query = "";
    if (categoryFilter == null) {
      query = "$uri/find";
    } else {
      query = "$uri/find?category=$categoryFilter";
    }

    final response = await client.get(Uri.parse(query));

    // Status OK
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);

      List<Product> products = (responseBody["body"] as List)
          .map((productData) => Product.fromJson(productData))
          .toList();

      return products;
    } else {
      return [];
    }
  }

  Future<List<ProductCategory>> getProductCategories() async {
    final response = await client.get(Uri.parse("$uri/find/categories"));

    // Status OK
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);

      List<ProductCategory> categories = (responseBody["body"] as List)
          .map((productData) => ProductCategory.fromJson(productData))
          .toList();

      return categories;
    } else {
      return [];
    }
  }
}
