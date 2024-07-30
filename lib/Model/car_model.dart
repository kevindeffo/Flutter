import 'package:cloud_firestore/cloud_firestore.dart';

class Car {
  String? id;
  String? carName;
  String? imageUrl;
  String? createdBy;
  Timestamp? createdAt;
  int? likes;
  bool? isMyFavoriteCar;
  List<String>? likedBy; // New field for storing user IDs who liked the car

  Car({
    this.id,
    this.carName,
    this.imageUrl,
    this.createdBy,
    this.createdAt,
    this.likes,
    this.isMyFavoriteCar,
    this.likedBy, // Initialize in constructor
  });

  // Convert a Car object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'carName': carName,
      'imageUrl': imageUrl,
      'createdBy': createdBy,
      'createdAt': createdAt,
      'likes': likes,
      'isMyFavoriteCar': isMyFavoriteCar,
      'likedBy': likedBy, // Include in map
    };
  }

  // Convert a Map object into a Car object
  Car.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        carName = map['carName'],
        imageUrl = map['imageUrl'],
        createdBy = map['createdBy'],
        createdAt = map['createdAt'],
        likes = map['likes'],
        isMyFavoriteCar = map['isMyFavoriteCar'],
        likedBy = List<String>.from(map['likedBy'] ?? []); // Parse likedBy from map
}
