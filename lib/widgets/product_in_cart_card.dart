import 'dart:convert';

import 'package:coffee_store/models/productincart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';

class ProductInCartCard extends StatefulWidget {
  final ProductInCart productInCart;

  const ProductInCartCard({super.key, required this.productInCart});

  @override
  ProductInCartCardState createState() => ProductInCartCardState();
}

class ProductInCartCardState extends State<ProductInCartCard> {
  final oCcy = NumberFormat("#,##0.00", "en_US");

  int currentQuantity = 1;

  static Future<List<ProductInCart>> getCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getStringList(Constants.shoppingCartKey) ?? [];
    return cartData
        .map((json) => ProductInCart.fromJson(jsonDecode(json)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.productInCart.product.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Cantidad: ${widget.productInCart.quantity}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Precio Total: \$${(widget.productInCart.quantity * widget.productInCart.product.price).toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
