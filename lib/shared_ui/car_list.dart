
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cars/shared_ui/single_car_widget.dart';
import 'package:provider/provider.dart';

import '../Model/car_model.dart';

class CarList extends StatelessWidget {
  final String userId;
  const CarList({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final cars = Provider.of<List<Car>>(context);
    return  SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: cars.length,
                (_, index) {
                  return SingleCarWidget(userId: userId, car: cars[index]);
                }
        )
    );
  }
}
