import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  final List<String> categories;
  final Function(String) onCategorySelected;

  const CategoriesPage(
      {super.key, required this.categories, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(categories[index]),
            onTap: () {
              onCategorySelected(categories[index]);
            },
          );
        },
      ),
    );
  }
}
