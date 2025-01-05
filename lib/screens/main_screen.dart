import 'package:flutter/material.dart';
import 'package:food_example/constants.dart';
import 'package:food_example/models/food.dart';
import 'package:food_example/screens/favorites_screen.dart';
import 'package:food_example/screens/home_screen.dart';
import 'package:food_example/screens/plan_screen.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTab = 0;
  List screens = const [
    HomeScreen(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    
  ];
  List<DocumentSnapshot> recipes = [];
  void initState () {
    getRecipes();
  }
  Future getRecipes () async {
    try {

      //получение коллекций
      QuerySnapshot collection = 
      await FirebaseFirestore.instance.collection('recipes').get();

      setState(() {
        recipes = collection.docs;

        print('recipes: $recipes');

      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    List<Food> favoriteFoods = foods.where((recipes) => recipes.isLiked).toList();

    List screens = [
      HomeScreen(),
      FavoritesScreen(favoriteFoods: favoriteFoods),
      PlanScreen(),
      Scaffold(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => setState(() {
                currentTab = 0;
              }),
              child: Column(
                children: [
                  Icon(
                    currentTab == 0 ? Iconsax.home5 : Iconsax.home,
                    color: currentTab == 0 ? kprimaryColor : Colors.grey,
                  ),
                  Text(
                    "Домой",
                    style: TextStyle(
                      fontSize: 14,
                      color: currentTab == 0 ? kprimaryColor : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => setState(() {
                currentTab = 1;
              }),
              child: Column(
                children: [
                  Icon(
                    currentTab == 1 ? Iconsax.heart5 : Iconsax.heart,
                    color: currentTab == 1 ? kprimaryColor : Colors.grey,
                  ),
                  Text(
                    "Любимые",
                    style: TextStyle(
                      fontSize: 14,
                      color: currentTab == 1 ? kprimaryColor : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => setState(() {
                currentTab = 2;
              }),
              child: Column(
                children: [
                  Icon(
                    currentTab == 2 ? Iconsax.calendar_25 : Iconsax.calendar_2,
                    color: currentTab == 2 ? kprimaryColor : Colors.grey,
                  ),
                  Text(
                    "План питания",
                    style: TextStyle(
                      fontSize: 14,
                      color: currentTab == 2 ? kprimaryColor : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => setState(() {
                currentTab = 3;
              }),
              child: Column(
                children: [
                  Icon(
                    currentTab == 3 ? Iconsax.setting5 : Iconsax.setting,
                    color: currentTab == 3 ? kprimaryColor : Colors.grey,
                  ),
                  Text(
                    "Настройки",
                    style: TextStyle(
                      fontSize: 14,
                      color: currentTab == 3 ? kprimaryColor : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: screens[currentTab], 
    );
  }
}
