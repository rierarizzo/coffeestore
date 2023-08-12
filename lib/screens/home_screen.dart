import 'package:coffee_store/models/product.dart';
import 'package:coffee_store/screens/profile_screen.dart';
import 'package:coffee_store/services/product_service.dart';
import 'package:coffee_store/widgets/home_header.dart';
import 'package:coffee_store/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Product> products = [];
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  // Obtiene los productos desde el backend
  void fetchProducts() async {
    List<Product> fetchedProducts = await ProductService().getProducts();

    setState(() {
      products = fetchedProducts;
    });
  }

  // Permite actualizar la lista de productos desde otro Widget.
  void updateProducts(List<Product> newProducts) {
    setState(() {
      products = newProducts;
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
        body: <Widget>[
          CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                // Se pasa función de updateProducts a Header para posteriormente
                // pasarlo al Widget de filtro de productos.
                delegate: HomeHeaderDelegate(
                    updateProducts: updateProducts, products: products),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ProductCard(product: products[index]);
                  },
                  childCount: products.length,
                ),
              ),
            ],
          ),
          ProfileScreen()
        ][currentPageIndex]);
  }
}
