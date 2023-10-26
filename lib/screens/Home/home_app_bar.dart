import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  final User? user;
  const HomeAppBar({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text('Fire cars'),
      floating: true,
      forceElevated: true,
      elevation: 1.0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/profile'),
            child: Hero(
              tag: user!.photoURL!,
              child: CircleAvatar(
                backgroundImage: NetworkImage(user!.photoURL!),
                backgroundColor: Colors.grey,
              ),
            ),
          ),
        )
      ],
    );
  }
}
