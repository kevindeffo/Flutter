import 'package:cloud_firestore/cloud_firestore.dart';

class Rental {
  String? id;
  String? carId;
  String? userId;
  String? identityDocument;
  String? rentalReason;
  bool? withDriver;
  Timestamp? startDate;
  Timestamp? endDate;
  String? status;

  Rental({
    this.id,
    this.carId,
    this.userId,
    this.identityDocument,
    this.rentalReason,
    this.withDriver,
    this.startDate,
    this.endDate,
    this.status,
  });

  // Convert a Rental object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'carId': carId,
      'userId': userId,
      'identityDocument': identityDocument,
      'rentalReason': rentalReason,
      'withDriver': withDriver,
      'startDate': startDate,
      'endDate': endDate,
      'status': status,
    };
  }

  // Convert a Map object into a Rental object
  Rental.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        carId = map['carId'],
        userId = map['userId'],
        identityDocument = map['identityDocument'],
        rentalReason = map['rentalReason'],
        withDriver = map['withDriver'],
        startDate = map['startDate'],
        endDate = map['endDate'],
        status = map['status'];
}
