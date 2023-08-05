import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterModalBottomSheet extends StatefulWidget {
  const FilterModalBottomSheet({super.key});

  @override
  FilterModalBottomSheetState createState() => FilterModalBottomSheetState();
}

class FilterModalBottomSheetState extends State<FilterModalBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController categoryController = TextEditingController();

  final List<DropdownMenuEntry<String>> categoryMenu =
      <DropdownMenuEntry<String>>[];

  @override
  Widget build(BuildContext context) {
    categoryMenu
        .add(const DropdownMenuEntry<String>(value: "PAS", label: "Pasteles"));

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
                  enableFilter: true,
                  leadingIcon: const Icon(Icons.filter_alt),
                  label: const Text('Filtrar por categoría'),
                  controller: categoryController,
                  dropdownMenuEntries: categoryMenu,
                  inputDecorationTheme: const InputDecorationTheme(
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(30),
                  child: CupertinoButton.filled(
                    onPressed: () {},
                    child: const Text("Filtrar"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
