import 'package:flutter/material.dart';
import 'package:food_example/constants.dart';
import 'package:food_example/models/food.dart';
import 'package:food_example/screens/home_screen.dart';
import 'package:food_example/screens/recipe_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cached_network_image/cached_network_image.dart';


class FavoritesScreen extends StatefulWidget {
  final List<Food> favoriteFoods;
  

  const FavoritesScreen({Key? key, required this.favoriteFoods}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<DocumentSnapshot> recipes = [];

  @override
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          },
        ),
        
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeScreen(recipes: recipes[index]),
                ),
              );
            },
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                        imageUrl: recipes[index]['image'], fit: BoxFit.cover,
                        placeholder: (context, url) => Center(child: CircularProgressIndicator()), // Временный индикатор загрузки
                        errorWidget: (context, url, error) => Icon(Icons.error), // Виджет для отображения при ошибке загрузки
                  width: 100,
                  height: 100,
                ),
              ),
              title: Text(recipes[index]['name']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${recipes[index]['cal']} калорий'),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 16),
                      SizedBox(width: 5),
                      Text('${recipes[index]['rate']}'),
                      SizedBox(width: 10),
                      Icon(Icons.comment, color: Colors.grey, size: 16),
                      SizedBox(width: 5),
                      Text('${recipes[index]['reviews']} отзывов'),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
