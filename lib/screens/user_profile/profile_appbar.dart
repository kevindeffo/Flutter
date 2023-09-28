import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cars/services/auth.dart';

class ProfileAppBar extends StatelessWidget {
  final User? user;
  const ProfileAppBar({this.user});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height*0.40,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(user!.photoURL!),fit: BoxFit.cover)
          ),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.transparent],
                begin: Alignment.bottomRight
              )
            ),
          ),
        ),
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: "${user!.displayName}\n",
                style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.black)
              ),
              TextSpan(
                  text: user!.email,
                  style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.black)
              ),
            ]
          ),

        ),
        titlePadding: const EdgeInsets.only(bottom: 20, left: 50.0),
      ),
      actions: [
        IconButton(onPressed: ()=>signOut(context), icon: const Icon(Icons.power_settings_new_outlined))
      ],
    );
  }

  signOut(BuildContext context) async{
    print("--------- Navigate pop ------------");
    Navigator.of(context).pop();

    print("--------- SignOut------------");
     await AuthService().signOut();
  }
}
