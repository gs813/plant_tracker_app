import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/plant.dart';
import '../providers/plant_provider.dart';

class PlantFormScreen extends StatefulWidget {

  final Plant? plant;

  const PlantFormScreen({super.key, this.plant});

  @override
  State<PlantFormScreen> createState() => _PlantFormScreenState();
}

class _PlantFormScreenState extends State<PlantFormScreen> {

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final typeController = TextEditingController();
  final waterController = TextEditingController();
  final noteController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.plant != null) {
      nameController.text = widget.plant!.name;
      typeController.text = widget.plant!.type;
      waterController.text = widget.plant!.watering;
      noteController.text = widget.plant!.note;
    }
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<PlantProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.plant == null ? "Add Plant" : "Edit Plant"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            children: [

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Plant Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter plant name";
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: typeController,
                decoration: const InputDecoration(labelText: "Type"),
              ),

              TextFormField(
                controller: waterController,
                decoration: const InputDecoration(labelText: "Watering"),
              ),

              TextFormField(
                controller: noteController,
                decoration: const InputDecoration(labelText: "Note"),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                child: const Text("Save"),
                onPressed: () {

                  if (!_formKey.currentState!.validate()) {
                    return;
                  }

                  final plant = Plant(
                    id: widget.plant?.id,
                    name: nameController.text,
                    type: typeController.text,
                    watering: waterController.text,
                    note: noteController.text,
                  );

                  if (widget.plant == null) {
                    provider.addPlant(plant);
                  } else {
                    provider.updatePlant(plant);
                  }

                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}