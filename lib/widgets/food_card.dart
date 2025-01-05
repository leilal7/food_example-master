import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_example/models/food.dart';
import 'package:food_example/screens/recipe_screen.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodCard extends StatefulWidget {
  final DocumentSnapshot recipes;
  const FoodCard({Key? key, required this.recipes}) : super(key: key);

  @override
  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        //onTap: () => Navigator.push(
        //context,
        //MaterialPageRoute(
        // builder: (context) => RecipeScreen(food: widget.recipes),
        //),
        //),
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      //  image: DecorationImage(
                      //    image: AssetImage(widget.recipes['image']),
                      //    fit: BoxFit.fill,
                      //  ),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.recipes['image'], fit: BoxFit.fill,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ), // Временный индикатор загрузки
                      errorWidget: (context, url, error) => Icon(Icons
                          .error), // Виджет для отображения при ошибке загрузки
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.recipes['name'],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Iconsax.flash_1,
                        size: 18,
                        color: Colors.grey,
                      ),
                      Text(
                        "${widget.recipes['cal']} Ккал",
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
                        "${widget.recipes['time']} Мин",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Iconsax.star5,
                          color: Colors.yellow.shade700, size: 20),
                      const SizedBox(width: 5),
                      Text(
                        "${widget.recipes['rate']}/5",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "(${widget.recipes['reviews']} Отзывов)",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade400,
                        ),
                      )
                    ],
                  )
                ],
              ),
              Positioned(
                top: 1,
                right: 1,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      // widget.recipes['isLiked'] = !widget.recipes['isLiked'];
                    });
                  },
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: const Size(30, 30),
                  ),
                  iconSize: 20,
                  icon: widget.recipes['isLiked']
                      ? const Icon(
                          Iconsax.heart5,
                          color: Colors.red,
                        )
                      : const Icon(Iconsax.heart),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
