import 'package:flutter/material.dart';
import '../models/plant.dart';

class PlantDetailScreen extends StatelessWidget {

  final Plant plant;

  const PlantDetailScreen({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(plant.name)),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("Name: ${plant.name}"),
            Text("Type: ${plant.type}"),
            Text("Watering: ${plant.watering}"),
            Text("Note: ${plant.note}"),

          ],
        ),
      ),
    );
  }
}