import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cars/screens/Home/add_car_widget.dart';
import 'package:flutter_cars/screens/Home/home_app_bar.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    print(_user);
    return Scaffold(
        body: SafeArea(
            child: CustomScrollView(
      slivers: [
        HomeAppBar(user: _user),
        AddCarWidget(user: _user)
      ],
    )));
  }
}
