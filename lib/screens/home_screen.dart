import 'package:coffee_store/models/product.dart';
import 'package:coffee_store/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products = [];
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts() async {
    List<Product> fetchedProducts = await ProductService().getProducts();

    setState(() {
      products = fetchedProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        labelBehavior: labelBehavior,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: SvgPicture.asset('assets/shopping-bag_selected.svg',
                width: 24, height: 24),
            icon: SvgPicture.asset('assets/shopping-bag.svg',
                width: 24, height: 24),
            label: 'Productos',
          ),
          NavigationDestination(
            selectedIcon: SvgPicture.asset('assets/user_selected.svg',
                width: 24, height: 24),
            icon: SvgPicture.asset('assets/user.svg', width: 24, height: 24),
            label: 'Mi perfil',
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
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
                          products[index].imageURL,
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
                                  products[index].name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    8.0, 0.0, 8.0, 0.0),
                                child: Text(
                                  products[index].description,
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
                                          "Precio: \$${products[index].price}",
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            /* ... */
                                          },
                                          icon: const Icon(
                                              Icons.add_shopping_cart),
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
        },
      ),
    );
  }
}
