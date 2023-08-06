import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/product_service.dart';

class SearchModalBottomSheet extends StatefulWidget {
  // Tiene un parámetro updateProducts que va a representar la función para
  // actualizar la lista de productos en el contexto de la pantalla principal.
  final Function(List<Product>) updateProducts;
  final List<Product> products;

  // Se debe pasar la función en el constructor desde el home screen.
  const SearchModalBottomSheet(
      {super.key, required this.updateProducts, required this.products});

  @override
  SearchModalBottomSheetState createState() => SearchModalBottomSheetState();
}

class SearchModalBottomSheetState extends State<SearchModalBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  String filter = "";

  // Obtiene los productos filtrados por categoría desde el backend
  Future<List<Product>> fetchFilteredProducts({String? filterCategory}) async {
    List<Product> fetchedProducts =
        await ProductService().getProducts(categoryFilter: filterCategory);

    return fetchedProducts;
  }

  @override
  Widget build(BuildContext context) {
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
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    labelText: "Filtrar por nombre",
                  ),
                  onSaved: (value) => filter = value!,
                ),
                Container(
                  margin: const EdgeInsets.all(30),
                  child: CupertinoButton.filled(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        List<Product> currentProducts = widget.products;
                        currentProducts = currentProducts
                            .where((p) => p.name
                                .toUpperCase()
                                .contains(filter.toUpperCase()))
                            .toList();
                        widget.updateProducts(currentProducts);

                        if (context.mounted) {
                          Navigator.pop(context);
                        }
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
