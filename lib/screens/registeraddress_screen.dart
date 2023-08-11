import 'package:coffee_store/screens/registercard_screen.dart';
import 'package:coffee_store/screens/shoppingcart_screen.dart';
import 'package:coffee_store/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterAddressScreen extends StatefulWidget {
  const RegisterAddressScreen({super.key});

  @override
  State<RegisterAddressScreen> createState() => _RegisterAddressScreenState();
}

class _RegisterAddressScreenState extends State<RegisterAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  String _detail = "";
  String _postalCode = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/background.webp"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.7),
              BlendMode.darken,
            ),
          ),
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.fromLTRB(150, 10, 150, 10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Detalle",
                      labelStyle: TextStyle(
                          color: Colors.white), // Color del texto del label
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .white), // Color del borde cuando está enfocado
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    onSaved: (value) => _detail = value!,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Código postal",
                      labelStyle: TextStyle(
                          color: Colors.white), // Color del texto del label
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .white), // Color del borde cuando está enfocado
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    onSaved: (value) => _postalCode = value!,
                  ),
                  Container(
                    margin: const EdgeInsets.all(30),
                    child: CupertinoButton.filled(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          bool isRegistered = await UserService()
                              .registerAddress(_detail, _postalCode);
                          if (!isRegistered) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Error al guardar')),
                              );
                            }
                            return;
                          }
                          if (context.mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterCardScreen()),
                            );
                          }
                        }
                      },
                      child: const Text("Registrar dirección"),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(30),
                    child: CupertinoButton.filled(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ShoppingCartScreen()),
                        );
                      },
                      child: const Text("Volver"),
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
