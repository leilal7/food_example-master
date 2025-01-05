import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_example/models/food.dart';
import 'package:food_example/widgets/food_card.dart';
import 'package:food_example/widgets/quick_screen_appbar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class QuickFoodsScreen extends StatefulWidget {
  const QuickFoodsScreen({super.key});

  @override
  State<QuickFoodsScreen> createState() => _QuickFoodsScreenState();
}

class _QuickFoodsScreenState extends State<QuickFoodsScreen> {
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const QuickScreenAppbar(),
                const SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 25,
                  ),
                  itemBuilder: (context, index) => FoodCard(
                    recipes: recipes[index],
                  ),
                  itemCount: recipes.length,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
