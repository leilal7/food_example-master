import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_example/screens/search_page.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController(); // Создание контроллера для поля поиска

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      child: Row(
        children: [
          Icon(Icons.search),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: searchController, // Присвоение контроллера полю ввода
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Поиск рецептов",
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
              onSubmitted: (value) {
                // Переход на страницу поиска и передача запроса
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchPage(query: searchController.text),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
