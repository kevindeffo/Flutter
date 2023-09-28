import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cars/screens/Home/home.dart';
import 'package:flutter_cars/screens/login_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);

    if (_user == null) {
      return const LoginScreen();
    } else {
      return const Home();
    }
  }
}
