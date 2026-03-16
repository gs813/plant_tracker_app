import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/plant_provider.dart';
import 'plant_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() =>
      Provider.of<PlantProvider>(context, listen: false).loadPlants()
    );
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<PlantProvider>(context);

    int totalPlants = provider.totalPlants;
    int indoorPlants =
        provider.plants.where((p) => p.type.toLowerCase() == "indoor").length;
    int outdoorPlants =
        provider.plants.where((p) => p.type.toLowerCase() == "outdoor").length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Plant Dashboard"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: SingleChildScrollView(
          child: Column(
            children: [

              Card(
                child: ListTile(
                  leading: const Icon(Icons.local_florist, color: Colors.green),
                  title: const Text("Total Plants"),
                  trailing: Text(
                    totalPlants.toString(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.home, color: Colors.blue),
                  title: const Text("Indoor Plants"),
                  trailing: Text(
                    indoorPlants.toString(),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.park, color: Colors.orange),
                  title: const Text("Outdoor Plants"),
                  trailing: Text(
                    outdoorPlants.toString(),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.list),
                  label: const Text("Open Plant List"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PlantListScreen(),
                      ),
                    );
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}