import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cars/Model/car_model.dart';
import 'package:flutter_cars/screens/shared_ui/show_snackbar.dart';
import 'package:flutter_cars/services/dbService.dart';
import 'package:provider/provider.dart';

class CarDetailsScreen extends StatelessWidget {
  const CarDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final car = ModalRoute.of(context)!.settings.arguments as Car;
    final userId = Provider.of<User?>(context)!.uid;
    final userName = Provider.of<User?>(context)!.displayName;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          car.carName!,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          car.createdBy == userName
              ? IconButton(
                  onPressed: () => onDeleteCar(context, car),
                  icon: Icon(Icons.delete_forever_outlined))
              : IconButton(
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
                )
        ],
      ),
      body: Center(
        child: InteractiveViewer(
          child: Hero(
            tag: car.imageUrl!,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(image: NetworkImage(car.imageUrl!))),
            ),
          ),
        ),
      ),
    );
  }

  void onDeleteCar(BuildContext context, Car car) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            icon: Icon(Icons.warning_amber),
            title: const Text("Attention!!!"),
            content: Text(
                "Voulez-vous vraiment supprimer la voiture ${car.carName} ?"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Annuler")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    DbService().deleteCar(car.id!);
                    showNotification(context, "Voiture supprimer avec succes");
                  },
                  child: Text("Supprimer"))
            ],
          );
        });
  }
}
