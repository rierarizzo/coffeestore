import 'package:coffee_store/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenScreenState();
}

class _SignInScreenScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";

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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _signInAndShowSnackBar(context, _email, _password);
                  }
                },
                child: const Text("Ingresar"),
              ),
            )
          ],
        ),
      ),
    )));
  }

  void _signInAndShowSnackBar(
      BuildContext context, String email, String password) async {
    bool isLogged = await AuthService().signIn(email, password);

    if (!isLogged) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Credenciales inválidas')),
        );
      }
    }
  }
}
