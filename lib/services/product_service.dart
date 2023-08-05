import 'dart:convert';

import 'package:coffee_store/models/product.dart';
import 'package:http/http.dart';

class ProductService {
  final client = Client();
  final uri = "http://localhost:8080";

  Future<List<Product>> getProducts() async {
    final response = await client.get(Uri.parse("$uri/products/find"));

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
}
