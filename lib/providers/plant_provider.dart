import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/plant.dart';

class PlantProvider extends ChangeNotifier {

  List<Plant> plants = [];

  Future loadPlants() async {
    plants = await DatabaseHelper.instance.getPlants();
    notifyListeners();
  }

  Future addPlant(Plant plant) async {

    await DatabaseHelper.instance.insertPlant(plant);

    await loadPlants();
  }

  Future deletePlant(int id) async {

    await DatabaseHelper.instance.deletePlant(id);

    await loadPlants();
  }

  Future updatePlant(Plant plant) async {

    await DatabaseHelper.instance.updatePlant(plant);

    await loadPlants();
  }

  int get totalPlants => plants.length;
}