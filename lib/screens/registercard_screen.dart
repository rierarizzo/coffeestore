import 'package:coffee_store/screens/home_screen.dart';
import 'package:coffee_store/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterCardScreen extends StatefulWidget {
  const RegisterCardScreen({super.key});

  @override
  State<RegisterCardScreen> createState() => _RegisterCardScreenState();
}

class _RegisterCardScreenState extends State<RegisterCardScreen> {
  final _formKey = GlobalKey<FormState>();

  String _cardNumber = "";
  int _expYear = 0;
  int _expMonth = 0;
  String _cvv = "";

  @override
  void initState() {
    super.initState();
  }

  // Widget que representa el formulario de registro de tarjeta de crédito/débito
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
                      labelText: "Número de tarjeta",
                      labelStyle: TextStyle(
                          color: Colors.white), // Color del texto del label
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .white), // Color del borde cuando está enfocado
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    onSaved: (value) => _cardNumber = value!,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Año de expiración",
                      labelStyle: TextStyle(
                          color: Colors.white), // Color del texto del label
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .white), // Color del borde cuando está enfocado
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _expYear = int.parse(value!),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Mes de expiración",
                      labelStyle: TextStyle(
                          color: Colors.white), // Color del texto del label
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .white), // Color del borde cuando está enfocado
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _expMonth = int.parse(value!),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "CVV",
                      labelStyle: TextStyle(
                          color: Colors.white), // Color del texto del label
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .white), // Color del borde cuando está enfocado
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    onSaved: (value) => _cvv = value!,
                  ),
                  Container(
                    margin: const EdgeInsets.all(30),
                    child: CupertinoButton.filled(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          bool isRegistered = await UserService().registerCard(
                              _cardNumber, _expYear, _expMonth, _cvv);
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
                                  builder: (context) => const HomeScreen()),
                            );
                          }
                        }
                      },
                      child: const Text("Comprar!"),
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
