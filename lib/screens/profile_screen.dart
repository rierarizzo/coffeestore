import 'package:coffee_store/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<User> userProfileFuture;
  @override
  void initState() {
    super.initState();
    userProfileFuture = fetchUserProfile();
  }

  Future<User> fetchUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idUser = prefs.getString('idUser') ?? '';
    try {
      int userId = int.parse(idUser);
      User user = await UserService().getProfileById(userId);
      return user;
    } catch (e) {
      print("Error al cargar el perfil del usuario: $e");
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.brown,
          title: const Text(
            'Editar perfil',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: FutureBuilder<User>(
          future: userProfileFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                  child: Text('Error al cargar el perfil del usuario'));
            } else {
              return Container(
                child: Column(
                  children: [
                    header(snapshot.data!),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        stripe(texto: 'Información de perfil'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(child: buildUserDetails(snapshot.data!)),
                  ],
                ),
              );
            }
          },
        ));
  }

  Widget header(User user) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          const SizedBox(height: 30),
          SvgPicture.asset('assets/profile.svg'),
          const SizedBox(height: 20),
          Text(user.username, style: TextStyle(fontSize: 30)),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 500),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;

                    const curve = Curves.ease;

                    final tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    final offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      EditProfileScreen(user: user),
                ),
              ).then((value) {
                if (value != null && value) {
                  fetchUserProfile().then((updatedUser) {
                    setState(() {
                      userProfileFuture =
                          Future.value(updatedUser); // Actualiza el Future
                    });
                  });
                }
              });
            },
            child: const Text(
              'Editar perfil',
              style: TextStyle(color: Color.fromARGB(255, 14, 139, 18)),
            ),
          ),
        ],
      ),
    );
  }

  Widget stripe({String? texto, String? icon}) {
    return Expanded(
      child: Container(
        alignment: Alignment.centerLeft,
        height: 50,
        color: Color.fromARGB(40, 158, 158, 158),
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            children: [
              if (icon != null) SvgPicture.asset(icon),
              const SizedBox(width: 5),
              Text(
                texto ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView buildUserDetails(User? user) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        switch (index) {
          case 1:
            return item("Nombre completo", user!.completeName ?? '',
                "completeName.svg");
          case 2:
            return item(
                "Nombre de usuario", user!.username ?? '', "completeName.svg");
          case 3:
            return item("Número de teléfono", user!.phoneNumber ?? '',
                "assets/telephone.svg");
          case 4:
            return Column(
              children: [
                item("Email", user!.email ?? '', "assets/email.svg"),
                Row(
                  children: [
                    stripe(texto: 'Cerrar Sesión', icon: 'assets/close.svg'),
                  ],
                ),
              ],
            );

          default:
            return SizedBox.shrink();
        }
      },
    );
  }

  Widget item(String label, String value, String icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          SvgPicture.asset(icon, height: 30, alignment: Alignment.center),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start),
              const SizedBox(height: 5),
              Text(value, textAlign: TextAlign.start)
            ],
          )
        ],
      ),
    );
  }
}
