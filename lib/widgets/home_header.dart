import 'package:coffee_store/widgets/search_modal.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import 'filter_modal.dart';

class HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  // Tiene un parámetro updateProducts que va a representar la función para
  // actualizar la lista de productos en el contexto de la pantalla principal.
  late final Function(List<Product>) updateProducts;
  List<Product> products = [];

  // Se debe pasar la función en el constructor desde el home screen.
  HomeHeaderDelegate({required this.updateProducts, required this.products});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = shrinkOffset / maxExtent;

    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 150),
            opacity: progress,
            child: const ColoredBox(
              color: Colors.brown,
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 150),
            opacity: 1 - progress,
            child: Image.asset(
              'assets/coffee_bk.jpg',
              fit: BoxFit.cover,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            padding: EdgeInsets.lerp(
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              const EdgeInsets.only(bottom: 16),
              progress,
            ),
            alignment: Alignment.lerp(
              Alignment.bottomLeft,
              Alignment.bottomCenter,
              progress,
            ),
            child: Text(
              'CafeLatte',
              style: TextStyle.lerp(
                Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.white),
                Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.white),
                progress,
              ),
            ),
          ),
          AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                color: Colors.white,
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return SearchModalBottomSheet(
                          updateProducts: updateProducts, products: products);
                    },
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.filter_alt),
                color: Colors.white,
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      // Se pasa función para actualizar los productos al modal
                      // del filtro de productos por categoría.
                      return FilterModalBottomSheet(
                          updateProducts: updateProducts);
                    },
                  );
                },
              ),
              IconButton(
                  icon: const Icon(Icons.shopping_cart), onPressed: () {})
            ],
            elevation: 0,
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 264;

  @override
  double get minExtent => 84;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
