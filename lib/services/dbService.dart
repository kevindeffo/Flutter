import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_cars/Model/car_model.dart';

class DbService {
  String? carId, userId;
  DbService({this.userId, this.carId});
  final CollectionReference _cars = FirebaseFirestore.instance.collection('cars');
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload cars Image
  Future<String> uploadFile(file) async {
    Reference reference = _storage.ref().child('cars/${DateTime.now()}.png');
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;

    return await taskSnapshot.ref.getDownloadURL();
  }

  // Save cars
  saveCar(Car car, file) async {
    String imageUrl = await uploadFile(file);
    car.imageUrl = imageUrl;
    _cars.add({
      'carName': car.carName,
      'imageUrl': car.imageUrl,
      'createdBy': car.createdBy,
      'createdDate': FieldValue.serverTimestamp(),
      'likes': 0,
      'isMyFavorite': false,
      'likedBy': [],
    });
  }

  // Get all cars
  Stream<List<Car>> get cars {
    Query carsQuery = _cars.orderBy('createdDate', descending: true);
    return carsQuery.snapshots().map((event) {
      return event.docs.map((e) {
        return Car(
          id: e.id,
          carName: e.get('carName'),
          createdBy: e.get('createdBy'),
          imageUrl: e.get('imageUrl'),
          likes: e.get('likes'),
          isMyFavoriteCar: e.get('isMyFavorite'),
          createdAt: e.get('createdDate'),
          likedBy: List<String>.from(e.get('likedBy') ?? []),
        );
      }).toList();
    });
  }

  // Add a like to a car
  Future<void> likeCar(String carId, String userId) async {
    final DocumentReference carDocRef = _cars.doc(carId);
    final DocumentSnapshot carDoc = await carDocRef.get();
    List<String> likedBy = List<String>.from(carDoc.get('likedBy') ?? []);
    if (!likedBy.contains(userId)) {
      likedBy.add(userId);
      carDocRef.update({
        'likes': likedBy.length,
        'likedBy': likedBy,
      });
    }
  }

  // Remove a like from a car
  Future<void> unlikeCar(String carId, String userId) async {
    final DocumentReference carDocRef = _cars.doc(carId);
    final DocumentSnapshot carDoc = await carDocRef.get();
    List<String> likedBy = List<String>.from(carDoc.get('likedBy') ?? []);
    if (likedBy.contains(userId)) {
      likedBy.remove(userId);
      carDocRef.update({
        'likes': likedBy.length,
        'likedBy': likedBy,
      });
    }
  }

  // Add a car to favorites
  Future<void> addFavoriteCar(Car car, String userId) async {
    final carDocRef = _cars.doc(car.id);

    final favoriteBy = carDocRef.collection('favoriteBy');

    Map<String, dynamic> data = {
      'carName': car.carName,
      'imageUrl': car.imageUrl,
      'createdBy': car.createdBy,
      'createdDate': car.createdAt,
      'likes': car.likes! + 1,
      'isMyFavorite': true,
    };
    try {
      await favoriteBy.doc(userId).set(data);
    } catch (e) {
      print(e);
    }
    carDocRef.update({'likes': car.likes! + 1});
  }

  // Remove a car from favorites
  void removeFavoriteCar(Car car, String userId) {
    final carDocRef = _cars.doc(car.id);
    final favoriteBy = carDocRef.collection('favoriteBy');
    favoriteBy.doc(userId).delete().then((_) {
      carDocRef.update({'likes': car.likes! - 1});
    }).catchError((e) {
      print(e);
    });
  }
}
