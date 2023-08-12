import 'package:coffee_store/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/user.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;

  const EditProfileScreen({required this.user, Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Editar perfil',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: Column(children: [
          header(),
          const SizedBox(height: 15),
          Row(
            children: [
              stripe('Información básica'),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(child: buildUserDetails(widget.user)),
        ]),
      ),
    );
  }

  Widget header() {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          const SizedBox(height: 30),
          SvgPicture.asset('assets/profile.svg'),
          const SizedBox(height: 20),
          const Text('Información del perfil', style: TextStyle(fontSize: 30)),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget stripe(String texto) {
    return Expanded(
      child: Container(
          alignment: Alignment.centerLeft,
          height: 50, // Alto de la franja
          color: Color.fromARGB(40, 158, 158, 158),
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              texto,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          )),
    );
  }

  ListView buildUserDetails(User user) {
    return ListView.builder(
      itemCount: 6, // Cantidad de campos en el objeto User
      itemBuilder: (context, index) {
        switch (index) {
          case 1:
            return Column(
              children: [
                item(
                  "Nombres",
                  user.completeName
                      .split(' ')
                      .take(2)
                      .join(' '), // Los dos primeros nombres
                  "completeName.svg",
                  (value) {
                    final newCompleteName = value +
                        ' ' +
                        user.completeName.split(' ').skip(2).join(' ');
                    user.completeName = newCompleteName;
                  },
                ),
                item(
                  "Apellidos",
                  user.completeName
                      .split(' ')
                      .skip(2)
                      .join(' '), // Los dos apellidos
                  "completeName.svg",
                  (value) {
                    final newCompleteName =
                        user.completeName.split(' ').take(2).join(' ') +
                            ' ' +
                            value;
                    user.completeName = newCompleteName;
                  },
                ),
              ],
            );
          case 2:
            return item("Nombre de usuario", user.username, "completeName.svg",
                (value) {
              user.username = value;
            });
          case 3:
            return item(
                "Número de teléfono", user.phoneNumber, "assets/telephone.svg",
                (value) {
              user.phoneNumber = value;
            });
          case 4:
            return Column(children: [
              item("Email", user.email, "assets/email.svg", (value) {
                user.email = value;
              }, disabled: true),
              buttonSave(),
            ]);

          default:
            return const SizedBox.shrink();
        }
      },
    );
  }

  Widget item(
      String label, String value, String icon, Function(String) onChanged,
      {bool? disabled}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          SvgPicture.asset(icon, height: 30, alignment: Alignment.center),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 0),
                TextFormField(
                  enabled: disabled != null ? !disabled : true,
                  initialValue: value, // Valor inicial del TextFormField
                  onChanged:
                      onChanged, // Función de devolución de llamada para actualizar el valor del User
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonSave() {
    final currentContext = context; // Almacenar el BuildContext en una variable

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: CupertinoButton.filled(
        onPressed: () async {
          try {
            await UserService().updateProfile(widget.user);
            Navigator.pop(currentContext, true);

            ScaffoldMessenger.of(currentContext).showSnackBar(
              SnackBar(
                content: const Text('Perfil actualizado exitosamente'),
                duration: const Duration(seconds: 2),
              ),
            );
          } catch (e) {
            print(
                'Error al actualizar el perfil: $e'); // Agregar este mensaje de log
            ScaffoldMessenger.of(currentContext).showSnackBar(
              SnackBar(
                content: const Text('Error al actualizar el perfil'),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: const Text("Guardar"),
      ),
    );
  }
}
