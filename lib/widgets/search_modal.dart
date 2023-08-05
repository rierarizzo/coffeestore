import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchModalBottomSheet extends StatefulWidget {
  const SearchModalBottomSheet({super.key});

  @override
  SearchModalBottomSheetState createState() => SearchModalBottomSheetState();
}

class SearchModalBottomSheetState extends State<SearchModalBottomSheet> {
  final _formKey = GlobalKey<FormState>();

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
