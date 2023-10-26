import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cars/screens/shared_ui/car_list.dart';
import 'package:flutter_cars/screens/user_profile/profile_appbar.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            ProfileAppBar(
              user: _user,
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              const Padding(
                padding: EdgeInsets.only(top: 25.0, left: 15.0, bottom: 12.0),
                child: Text("Mes favoris"),
              ),
              const Divider()
            ])),
            CarList(
              userId: _user!.uid,
              pageName: "profile",
            )
          ],
        ),
      ),
    );
  }
}
