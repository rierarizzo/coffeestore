import 'package:coffee_store/screens/home_screen.dart';
import 'package:coffee_store/screens/signin_screen.dart';
import 'package:coffee_store/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  String _username = "";
  String _name = "";
  String _surname = "";
  String _phone = "";
  String _email = "";
  String _password = "";
  String _role = "A";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      margin: const EdgeInsets.fromLTRB(150, 10, 150, 10),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: "Username"),
              keyboardType: TextInputType.username,
              onSaved: (value) => _username = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Name"),
              keyboardType: TextInputType.name,
              onSaved: (value) => _name = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Surname"),
              keyboardType: TextInputType.surname,
              onSaved: (value) => _surname = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Phone"),
              keyboardType: TextInputType.phone,
              onSaved: (value) => _phone = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) => _email = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Contraseña"),
              obscureText: true,
              onSaved: (value) => _password = value!,
            ),
            Container(
              margin: const EdgeInsets.all(30),
              child: CupertinoButton.filled(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    bool isLogged = await AuthService().signUp(
                        _username, _name, _surname, _phone, _email, _password);
                    if (!isLogged) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Ingrese todos los campos')),
                        );
                      }
                      return;
                    }

                    if (context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInScreen()),
                      );
                    }
                  }
                },
                child: const Text("Registrar"),
              ),
            )
          ],
        ),
      ),
    )));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('_username', _username));
  }
}
