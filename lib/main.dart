import 'package:flutter/material.dart';
import 'package:food_example/constants.dart';
import 'package:food_example/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
      apiKey: "AIzaSyDIBXjoGfRFO8g1SJR8ed7TEf9q7dKt2n8",
      appId: 'com.example.food_example',
      messagingSenderId: 'sendid',
      projectId: 'food-example-c9c34',
      storageBucket: 'food-example-c9c34.appspot.com',));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Biofit",
        colorScheme: ColorScheme.fromSeed(seedColor: kprimaryColor),
        scaffoldBackgroundColor: kbackgroundColor,
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}
