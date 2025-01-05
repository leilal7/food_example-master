import 'package:flutter/material.dart';
import 'package:food_example/models/food.dart';
import 'package:food_example/screens/quick_foods_screen.dart';
import 'package:food_example/screens/recipe_screen.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cached_network_image/cached_network_image.dart';


class QuickAndFastList extends StatefulWidget {
  const QuickAndFastList({super.key});

  @override
  State<QuickAndFastList> createState() => _QuickAndFastListState();
}

class _QuickAndFastListState extends State<QuickAndFastList> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Быстро и вкусно",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QuickFoodsScreen(),
                ),
              ),
              child: const Text("Еще..."),
            ),
          ],
        ),
        const SizedBox(height: 15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              recipes.length,
              (index) => GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeScreen(recipes: recipes[index]),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 200,
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              // image: DecorationImage(
                              //   image: AssetImage(recipes[index]['image']),
                              //  
                              // ),
                            ),

                            // child: Image.network( recipes[index]['image']),
                              child:  CachedNetworkImage(
                                imageUrl: recipes[index]['image'], fit: BoxFit.fill,
                                placeholder: (context, url) => Center(child: CircularProgressIndicator()), // Временный индикатор загрузки
                                errorWidget: (context, url, error) => Icon(Icons.error), // Виджет для отображения при ошибке загрузки
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            recipes[index]['name'],
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Iconsax.flash_1,
                                size: 18,
                                color: Colors.grey,
                              ),
                              Text(
                                "${recipes[index]['cal']} Ккал",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const Text(
                                " · ",
                                style: TextStyle(color: Colors.grey),
                              ),
                              const Icon(
                                Iconsax.clock,
                                size: 18,
                                color: Colors.grey,
                              ),
                              Text(
                                "${recipes[index]['time']} Мин",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Positioned(
                        top: 1,
                        right: 1,
                        child: IconButton(
                          onPressed: () {},
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white,
                            fixedSize: const Size(30, 30),
                          ),
                          iconSize: 20,
                          icon: const Icon(Iconsax.heart),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
