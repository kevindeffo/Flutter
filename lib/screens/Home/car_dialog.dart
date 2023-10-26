import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cars/services/dbService.dart';
import 'package:flutter_cars/screens/shared_ui/show_snackbar.dart';
import 'package:image_picker/image_picker.dart';

import '../../Model/car_model.dart';

class CarDialog {
  User? user;
  CarDialog({this.user});

  final Key _keyForm = GlobalKey<FormState>();
  String _carName = '';
  String _errorMessage = '';

  void showCarDialog(BuildContext context, ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    File _file = File(pickedFile!.path);
    if (context.mounted) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              contentPadding: EdgeInsets.zero,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.grey,
                      image: DecorationImage(
                          image: FileImage(_file), fit: BoxFit.cover)),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Form(
                          key: _keyForm,
                          child: Column(
                            children: [
                              TextFormField(
                                maxLength: 30,
                                onChanged: (value) => _carName = value,
                                validator: (value) =>
                                    _carName == '' ? _errorMessage : null,
                                decoration: const InputDecoration(
                                    label: Text('Nom de la Voiture'),
                                    border: OutlineInputBorder()),
                              ),
                            ],
                          )),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Wrap(
                          children: [
                            TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('ANNULER')),
                            ElevatedButton(
                                onPressed: () => saveCar(
                                    context, _keyForm, _file, _carName, user),
                                child: const Text("PUBLIER"))
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          });
    }
  }

  void saveCar(BuildContext context, keyForm, file, carName, user) {
    if (keyForm.currentState.validate()) {
      Navigator.of(context).pop();
      showNotification(context, "Sauvegarde en cours");
      Car car = Car(carName: carName, createdBy: user!.displayName);
      DbService().saveCar(car, file);
    }
  }
}
