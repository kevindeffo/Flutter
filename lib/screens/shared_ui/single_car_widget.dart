import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cars/screens/shared_ui/favorite_badge.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Model/car_model.dart';
import '../../services/dbService.dart';

class SingleCarWidget extends StatelessWidget {
  final String userId;
  final Car car;
  const SingleCarWidget({super.key, required this.userId, required this.car});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, "/details", arguments: car),
            child: Hero(
              tag: car.imageUrl!,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.35,
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                        image: NetworkImage(car.imageUrl!), fit: BoxFit.cover)),
              ),
            ),
          ),
          FavoriteBadge(car: car, userId: userId)
        ]),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    car.carName!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    "Créé par: ${car.createdBy!}",
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(
                      car.likedBy!.contains(userId)
                          ? Icons.thumb_up
                          : Icons.thumb_up_alt_outlined,
                      color: car.likedBy!.contains(userId)
                          ? Colors.blue
                          : Colors.grey,
                    ),
                    onPressed: () {
                      if (car.likedBy!.contains(userId)) {
                        DbService().unlikeCar(car.id!, userId);
                      } else {
                        DbService().likeCar(car.id!, userId);
                      }
                    },
                  ),
                  Text("${car.likes ?? 0} likes"),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  String formattingDate(Timestamp? timestamp) {
    initializeDateFormatting("fr", null);
    DateTime dateTime = timestamp!.toDate();
    DateFormat dateFormat = DateFormat.MMMd('fr');
    return dateFormat.format(dateTime ?? DateTime.now());
  }
}
