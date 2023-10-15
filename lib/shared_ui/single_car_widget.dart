import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cars/shared_ui/favorite_badge.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../Model/car_model.dart';

class SingleCarWidget extends StatelessWidget {
  final String userId;
  final Car car;
  const SingleCarWidget({super.key, required this.userId, required this.car});

  @override
  Widget build(BuildContext context) {
    // SimpleDateFormat sfd = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
    // print(car.createdAt!.toDate().toDateString());
    print(car.imageUrl!);
    return  Column(
      children: [
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.35,
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      image: NetworkImage(car.imageUrl!),
                      fit: BoxFit.cover
                  )
              ),
            ),
            FavoriteBadge(car: car, userId: userId)
          ]
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(car.carName!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                  Text(car.createdBy!,
                    style: const TextStyle(
                      fontSize: 15
                    ),
                  )
                ],
              ),
              Text(formattingDate(car.createdAt))
            ],
          ),
        )
      ],
    );
  }

  String formattingDate(Timestamp? timestamp){
    initializeDateFormatting("fr", null);
    DateTime dateTime = timestamp!.toDate();
    DateFormat dateFormat = DateFormat.MMMd('fr');
    return dateFormat.format(dateTime ?? DateTime.now());
  }
}
