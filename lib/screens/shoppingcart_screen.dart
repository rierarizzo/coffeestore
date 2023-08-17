import 'dart:convert';

import 'package:coffee_store/screens/home_screen.dart';
import 'package:coffee_store/screens/registeraddress_screen.dart';
import 'package:coffee_store/widgets/product_in_cart_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import '../models/productincart.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  ShoppingCartScreenState createState() => ShoppingCartScreenState();
}

class ShoppingCartScreenState extends State<ShoppingCartScreen> {
  List<ProductInCart> productsInCart = [];
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  @override
  void initState() {
    super.initState();
    getCart();
  }

  Future<void> getCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getStringList(Constants.shoppingCartKey) ?? [];
    List<ProductInCart> fetchedProducts = cartData
        .map((json) => ProductInCart.fromJson(jsonDecode(json)))
        .toList();

    setState(() {
      productsInCart = fetchedProducts;
    });
  }

  // Widget de lista de tarjetas de productos en el carrito de compras
  // Usa listview para la lista
  // FloactingActionButton para los botones flotantes (botón para regresar a la
  // pantalla principal y botón para comprar)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
          itemCount: productsInCart.length,
          itemBuilder: (context, index) {
            return ProductInCartCard(productInCart: productsInCart[index]);
          },
        ),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterAddressScreen()),
                );
              },
              child: const Icon(Icons.shop),
            ),
            const SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: const Icon(Icons.arrow_back),
            ),
          ],
        ));
  }
}
