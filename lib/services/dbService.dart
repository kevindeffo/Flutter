import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_cars/Model/car_model.dart';

class DbService {
  String? carId, userId;
  DbService({this.userId, this.carId});
  final CollectionReference _cars =
      FirebaseFirestore.instance.collection('cars');
  final FirebaseStorage _storage = FirebaseStorage.instance;

  //Upload cars Image
  Future<String> uploadFile(file) async {
    Reference reference = _storage.ref().child('cars/${DateTime.now()}.png');
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;

    return await taskSnapshot.ref.getDownloadURL();
  }

  //save cars
  saveCar(Car car, file) async {
    String imageUrl = await uploadFile(file);
    car.imageUrl = imageUrl;
    _cars.add({
      "carName": car.carName,
      "imageUrl": car.imageUrl,
      "createdBy": car.createdBy,
      "createdDate": FieldValue.serverTimestamp(),
      "likes": 0,
      "isMyFavorite": false
    });
  }

  // Recuperer toutes les voitures
  Stream<List<Car>> get cars {
    Query carsQuery = _cars.orderBy("createdDate", descending: true);
    // print('--------- ${carsQuery.snapshots()} ---------------------------');
    return carsQuery.snapshots().map((event) {
      return event.docs.map((e) {
        print('--------- ${e.get("createdDate")} ---------------------------');
        return Car(
            id: e.id,
            carName: e.get("carName"),
            createdBy: e.get("createdBy"),
            imageUrl: e.get("imageUrl"),
            likes: e.get("likes"),
            isMyFavoriteCar: e.get("isMyFavorite"),
            createdAt: e.get("createdDate"));
      }).toList();
    });
  }

  // Ajouter une voiture aux favoris
  Future<void> addFavoriteCar(Car car, String userId) async {
    final carDocRef = _cars.doc(car.id);

    print("----------DocRef $carDocRef ----------------");
    final favoriteBy = carDocRef.collection('favoriteBy');
    print("-------------favoriteBy $favoriteBy ---------------");

    Map<String, dynamic> data = {
      "carName": car.carName,
      "imageUrl": car.imageUrl,
      "createdBy": car.createdBy,
      "createdDate": car.createdAt,
      "likes": car.likes! + 1,
      "isMyFavorite": true
    };
    print(data['isMyFavorite']);
    try {
      print('----- Start try catch --------');
      await favoriteBy.doc(userId).set(data).then((value) {
        print(favoriteBy.doc(userId).get());
      });
      print('----- End try catch --------');
    } catch (e) {
      print('----- Error try catch --------');
      print(e);
    }
    carDocRef.update({"likes": car.likes! + 1});
  }

  // Retirer une voiture des favoris
  void removeFavoriteCar(Car car, String userId) {
    final carDocRef = _cars.doc(car.id);
    final favoriteBy = carDocRef.collection('favoriteBy');

    carDocRef.update({
      "likes": car.likes! - 1,
      "isMyFavorite": false,
    });

    favoriteBy.doc(userId).delete();
  }

  // recuperer les voitures favoris
  Stream<Car> get myFavoriteCar {
    final favoriteBy = _cars.doc(carId).collection('favoriteBy');
    return favoriteBy.doc(userId).snapshots().map((e) {
      print('----- Favorite cars --------');
      print(e.data());
      return Car(
          id: e.id,
          carName: e.get("carName"),
          createdBy: e.get("createdBy"),
          imageUrl: e.get("imageUrl"),
          likes: e.get("likes"),
          isMyFavoriteCar: e.get("isMyFavorite"),
          createdAt: e.get("createdDate"));
    });
  }

  // Supprimmer une voiture
  Future<void> deleteCar(String carId) => _cars.doc(carId).delete();
}
