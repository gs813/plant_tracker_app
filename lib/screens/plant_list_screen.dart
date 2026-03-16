import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/plant_provider.dart';
import 'plant_form_screen.dart';
import 'plant_detail_screen.dart';

class PlantListScreen extends StatefulWidget {
  const PlantListScreen({super.key});

  @override
  State<PlantListScreen> createState() => _PlantListScreenState();
}

class _PlantListScreenState extends State<PlantListScreen> {

  String search = "";

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<PlantProvider>(context);

    final plants = provider.plants
        .where((p) => p.name.toLowerCase().contains(search))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Plant List"),
      ),

      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: const InputDecoration(
                labelText: "Search Plant",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value){
                setState(() {
                  search = value.toLowerCase();
                });
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: plants.length,
              itemBuilder: (context, index) {

                final plant = plants[index];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),

                  child: ListTile(

                    leading: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PlantFormScreen(plant: plant),
                          ),
                        );
                      },
                    ),

                    title: Text(plant.name),
                    subtitle: Text(plant.type),

                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PlantDetailScreen(plant: plant),
                        ),
                      );
                    },

                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: (){

                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text("Delete Plant"),
                            content: const Text(
                                "Are you sure you want to delete this plant?"
                            ),
                            actions: [

                              TextButton(
                                child: const Text("Cancel"),
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                              ),

                              TextButton(
                                child: const Text("Delete"),
                                onPressed: (){
                                  provider.deletePlant(plant.id!);
                                  Navigator.pop(context);
                                },
                              ),

                            ],
                          ),
                        );

                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const PlantFormScreen(),
            ),
          );
        },
      ),
    );
  }
}