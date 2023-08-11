import 'dart:convert';

import 'package:coffee_store/models/product.dart';
import 'package:coffee_store/models/productincart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  ProductCardState createState() => ProductCardState();
}

class ProductCardState extends State<ProductCard> {
  final oCcy = NumberFormat("#,##0.00", "en_US");

  int currentQuantity = 1;

  static Future<List<ProductInCart>> getCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getStringList(Constants.shoppingCartKey) ?? [];
    return cartData
        .map((json) => ProductInCart.fromJson(jsonDecode(json)))
        .toList();
  }

  Future<void> addToCart(Product product, int quantity) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    ProductInCart productInCart =
        ProductInCart(product: product, quantity: quantity);

    List<ProductInCart> shoppingCart = await getCart();

    shoppingCart.add(productInCart);
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
                    widget.product.imageURL!,
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
                            widget.product.description!,
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(width: 8),
                                Text(
                                  "Precio: \$${oCcy.format(widget.product.price)}",
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            )),
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            currentQuantity++;
                                          });
                                        },
                                        icon: const Icon(Icons.add)),
                                    Text("$currentQuantity"),
                                    IconButton(
                                        onPressed: () {
                                          if (currentQuantity > 1) {
                                            setState(() {
                                              currentQuantity--;
                                            });
                                          }
                                        },
                                        icon: const Icon(Icons.remove))
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    addToCart(widget.product, currentQuantity);
                                  },
                                  icon: const Icon(Icons.add_shopping_cart),
                                )
                              ],
                            )),
                            const SizedBox(width: 8)
                          ],
                        ))
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
