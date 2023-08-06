import 'package:coffee_store/models/productcategory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/product_service.dart';

class FilterModalBottomSheet extends StatefulWidget {
  // Tiene un parámetro updateProducts que va a representar la función para
  // actualizar la lista de productos en el contexto de la pantalla principal.
  final Function(List<Product>) updateProducts;

  // Se debe pasar la función en el constructor desde el home screen.
  const FilterModalBottomSheet({super.key, required this.updateProducts});

  @override
  FilterModalBottomSheetState createState() => FilterModalBottomSheetState();
}

class FilterModalBottomSheetState extends State<FilterModalBottomSheet> {
  // Categorías de producto.
  List<ProductCategory> productCategories = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController categoryController = TextEditingController();

  // Representa la lista de objetos necesarios para cargar el dropdown menú.
  final List<DropdownMenuEntry<String>> categoryMenu =
      <DropdownMenuEntry<String>>[];

  // Categoría seleccionada desde el menú.
  String? selectedCategory = "";

  @override
  void initState() {
    super.initState();
    fetchProductCategories();
  }

  // Obtiene las categorías de productos desde el backend.
  void fetchProductCategories() async {
    List<ProductCategory> fetchedCategories =
        await ProductService().getProductCategories();

    setState(() {
      productCategories = fetchedCategories;
    });
  }

  // Obtiene los productos filtrados por categoría desde el backend
  Future<List<Product>> fetchFilteredProducts({String? filterCategory}) async {
    List<Product> fetchedProducts =
        await ProductService().getProducts(categoryFilter: filterCategory);

    return fetchedProducts;
  }

  @override
  Widget build(BuildContext context) {
    for (ProductCategory category in productCategories) {
      categoryMenu.add(DropdownMenuEntry<String>(
          value: category.code, label: category.description));
    }

    return Container(
      height: 250,
      color: Colors.white60,
      child: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(150, 10, 150, 10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                DropdownMenu<String>(
                  width: 264,
                  enableFilter: false,
                  leadingIcon: const Icon(Icons.filter_alt),
                  label: const Text('Filtrar por categoría'),
                  controller: categoryController,
                  dropdownMenuEntries: categoryMenu,
                  inputDecorationTheme: const InputDecorationTheme(
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                  ),
                  onSelected: (String? category) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                ),
                Container(
                  margin: const EdgeInsets.all(30),
                  child: CupertinoButton.filled(
                    onPressed: () async {
                      List<Product> products = await fetchFilteredProducts(
                          filterCategory: selectedCategory);
                      widget.updateProducts(products);

                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Filtrar"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: CupertinoButton.filled(
                    onPressed: () async {
                      List<Product> products =
                          await fetchFilteredProducts(filterCategory: null);
                      widget.updateProducts(products);

                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Limpiar filtros"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
