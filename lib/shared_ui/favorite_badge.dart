import 'package:flutter/material.dart';

import '../Model/car_model.dart';

class FavoriteBadge extends StatefulWidget {
  final Car car;
  final String userId;
   const FavoriteBadge({super.key, required this.car, required this.userId});

  @override
  State<FavoriteBadge> createState() => _FavoriteBadgeState();
}

class _FavoriteBadgeState extends State<FavoriteBadge> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 4.0,
        right: 12.0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.grey.withOpacity(0.7),
          ),
          child: widget.car.isMyFavoriteCar! ? Row(
            children: [
              widget.car.likes! > 0
              ?Text('${widget.car.likes}',
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold
                ),
              ):Container(),
              const Icon(Icons.favorite, color: Colors.red,)
            ],
          ):Row(
            children: [
              widget.car.likes! > 0
              ?Text('${widget.car.likes}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ):Container(),
              const Icon(Icons.favorite,)
            ],
          ),
        )
    );
  }
}
