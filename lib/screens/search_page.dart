import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_example/screens/recipe_screen.dart';
import 'package:food_example/widgets/food_card.dart';

class SearchPage extends StatefulWidget {
  final String query;

  SearchPage({required this.query}) : super(key: null);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Результаты поиска'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('recipes')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // Функция для очистки строки от указанных знаков препинания и пробелов и приведения к нижнему регистру
          String cleanString(String text) {
            return text.toLowerCase().replaceAll(RegExp(r'[-.,:;\/\\ ]'), '');
          }

          // Преобразование запроса пользователя и названий рецептов к очищенному виду для сравнения
          String queryCleaned = cleanString(widget.query);

          // Фильтрация рецептов по наличию очищенного запроса в очищенном названии рецепта
          List<DocumentSnapshot> filteredRecipes = snapshot.data!.docs
              .where((doc) =>
                  cleanString(doc['name']).contains(queryCleaned))
              .toList();

          if (filteredRecipes.isEmpty) {
            return Center(
              child: Text('Нет результатов'),
            );
          }

          return ListView.builder(
            itemCount: filteredRecipes.length,
            itemBuilder: (context, index) {
              DocumentSnapshot recipe = filteredRecipes[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeScreen(recipes: recipe),
                    ),
                  );
                },
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: 
                    CachedNetworkImage(
                      imageUrl: recipe[index]['image'],
                      placeholder: (context, url) => Center(child: CircularProgressIndicator()), // Временный индикатор загрузки
                      errorWidget: (context, url, error) => Icon(Icons.error), // Виджет для отображения при ошибке загрузки

                    // Image.network(
                    //   recipe['image'], // Обращение к полю 'image' у объекта recipe
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(recipe['name']), // Обращение к полю 'name' у объекта recipe
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${recipe['cal']} калорий'), // Обращение к полю 'cal' у объекта recipe
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 16),
                          SizedBox(width: 5),
                          Text('${recipe['rate']}'),
                          SizedBox(width: 10),
                          Icon(Icons.comment, color: Colors.grey, size: 16),
                          SizedBox(width: 5),
                          Text('${recipe['reviews']} отзывов'),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
