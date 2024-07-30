import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cars/screens/shared_ui/single_car_widget.dart';
import 'package:flutter_cars/services/dbService.dart';
import 'package:provider/provider.dart';

import '../../Model/car_model.dart';

class CarList extends StatelessWidget {
  final String userId;
  String? pageName;
  CarList({super.key, required this.userId, this.pageName});

  @override
  Widget build(BuildContext context) {
    final cars = Provider.of<List<Car>>(context);
    return SliverList(
        delegate: SliverChildBuilderDelegate(childCount: cars.length, (_, index) {
      return StreamBuilder(
        stream: DbService(userId: userId, carId: cars[index].id).myFavoriteCar,
        builder: (context, snapshot) {
          if (pageName == "profile") {
            if (!snapshot.hasData) return Container();
            cars[index].isMyFavoriteCar = true;
            return SingleCarWidget(userId: userId, car: cars[index]);
          }
          if (snapshot.hasData) {
            cars[index].isMyFavoriteCar = true;
            return SingleCarWidget(userId: userId, car: cars[index]);
          } else {
            cars[index].isMyFavoriteCar = false;
            return SingleCarWidget(userId: userId, car: cars[index]);
          }
        },
      );
    }));
  }
}
