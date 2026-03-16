import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/plant_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => PlantProvider(),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Plant Management App',

        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.green,
        ),

        darkTheme: ThemeData.dark(useMaterial3: true),

        themeMode: ThemeMode.system,

        home: const HomeScreen(),
      ),
    );
  }
}