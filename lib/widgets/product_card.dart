import 'dart:convert';

import 'package:coffee_store/models/product.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  ProductCardState createState() => ProductCardState();
}

class ProductCardState extends State<ProductCard> {
  static Future<List<Product>> getCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getStringList(Constants.shoppingCartKey) ?? [];
    return cartData.map((json) => Product.fromJson(jsonDecode(json))).toList();
  }

  Future<void> addToCart(Product product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Product> shoppingCart = await getCart();

    shoppingCart.add(product);
    final cartData = shoppingCart
        .map((productInCart) => jsonEncode(productInCart.toJson()))
        .toList();

    await prefs.setStringList(Constants.shoppingCartKey, cartData);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(6.0, 3.0, 6.0, 3.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SizedBox(
            height: 150,
            child: Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.network(
                    widget.product.imageURL,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.product.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                          child: Text(
                            widget.product.description,
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  const SizedBox(width: 8),
                                  Text(
                                    "Precio: \$${widget.product.price}",
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      addToCart(widget.product);
                                    },
                                    icon: const Icon(Icons.add_shopping_cart),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
