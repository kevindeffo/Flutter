import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cars/screens/shared_ui/show_snackbar.dart';
import 'package:flutter_cars/services/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _homeKey =
      GlobalKey<FormState>(debugLabel: '_homeScreenkey');
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/fire_car.png')))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Fire Cars',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Colors.black54, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Partagez votre amour pour les voitures avec d'autres persone dans le monde",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Colors.black54, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              !isLoading
                  ? ElevatedButton(
                      onPressed: () {
                        signInWithGoogle(context);
                      },
                      child: const Text("Se connecter avec Google"))
                  : const Center(
                      child: CircularProgressIndicator(),
                    )
            ],
          ),
        ),
      ),
    );
  }

  signInWithGoogle(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
          AuthService().signinWithGoogle().then((value) {
            isLoading = false;
            print("Valeur: $value");
          });
        });
      }
    } on SocketException catch (_) {
      showNotification(context, "Verifiez votre connexion internet");
    }
  }
}
