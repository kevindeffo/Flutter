import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_cars/Model/car_model.dart';

class DbService {
  final CollectionReference _cars = FirebaseFirestore.instance.collection('cars');
  final FirebaseStorage _storage = FirebaseStorage.instance;

  //Upload cars Image
  Future<String> uploadFile(file) async{
    Reference reference = _storage.ref().child('cars/${DateTime.now()}.png');
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;

    return await taskSnapshot.ref.getDownloadURL();
  }

  //save cars
  saveCar(Car car, file)async{
    String imageUrl = await uploadFile(file);
    car.imageUrl = imageUrl;
    _cars.add({
      "carName":car.carName,
      "imageUrl":car.imageUrl,
      "createdBy":car.createdBy,
      "createdDate":FieldValue.serverTimestamp(),
      "likes":0,
      "isMyFavorite": false
    });
  }

  Stream<List<Car>> get cars{
    Query carsQuery = _cars.orderBy("createdDate", descending: true);
    // print('--------- ${carsQuery.snapshots()} ---------------------------');
    return carsQuery.snapshots().map((event){
      return event.docs.map((e){
        print('--------- ${e.get("createdDate")} ---------------------------');
        return Car(id:e.id,
            carName: e.get("carName"),
            createdBy: e.get("createdBy"),
        imageUrl:e.get("imageUrl"),
          likes: e.get("likes"),
          isMyFavoriteCar: e.get("isMyFavorite"),
          createdAt: e.get("createdDate")
        );
      }).toList();
    });
  }

  getUserById(String id){

  }
}