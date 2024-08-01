import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_cars/Model/rental_model.dart';

class DbService {
  String? carId, userId;
  DbService({this.userId, this.carId});
  final CollectionReference _cars = FirebaseFirestore.instance.collection('cars');
  final CollectionReference _rentals = FirebaseFirestore.instance.collection('rentals');
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload document
  Future<String> uploadFile(file) async {
    Reference reference = _storage.ref().child('documents/${DateTime.now()}.png');
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;

    return await taskSnapshot.ref.getDownloadURL();
  }

  // Add rental
  Future<void> addRental(Rental rental, file) async {
    rental.identityDocument = await uploadFile(file);
    _rentals.add(rental.toMap());
  }

  // Get rentals
  Stream<List<Rental>> get rentals {
    return _rentals.snapshots().map((event) {
      return event.docs.map((e) {
        return Rental.fromMap(e.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Update rental
  Future<void> updateRentalStatus(String rentalId, String status) async {
    await _rentals.doc(rentalId).update({'status': status});
  }

  // Check car availability
  Future<bool> isCarAvailable(String carId, Timestamp startDate, Timestamp endDate) async {
    final rentals = await _rentals
        .where('carId', isEqualTo: carId)
        .where('startDate', isLessThanOrEqualTo: endDate)
        .where('endDate', isGreaterThanOrEqualTo: startDate)
        .get();
    return rentals.docs.isEmpty;
  }
}
