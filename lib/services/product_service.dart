import 'dart:convert';

import 'package:coffee_store/models/product.dart';
import 'package:http/http.dart';
import 'package:loggy/loggy.dart';

class ProductService {
  final client = Client();
  final uri = "http://localhost:8080";

  Future<List<Product>> getProducts() async {
    final response = await client.get(Uri.parse("$uri/products/find"));

    // Status OK
    if (response.statusCode == 200) {
      final List<dynamic> responseBody = json.decode(response.body);
      List<Product> products = responseBody
          .map((productData) => Product.fromJson(productData))
          .toList();

      logDebug(products[0].name);

      return products;
    } else {
      logError(response.statusCode);

      return [];
    }
  }
}
