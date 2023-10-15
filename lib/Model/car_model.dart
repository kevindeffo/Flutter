import 'package:cloud_firestore/cloud_firestore.dart';

class Car{
  String? id,  carName, imageUrl, createdBy;
  Timestamp? createdAt;
  bool? isMyFavoriteCar;
  int? likes;

  Car({this.id, required this.carName,  this.imageUrl, this.createdAt,required this.createdBy,  this.isMyFavoriteCar, this.likes});
}