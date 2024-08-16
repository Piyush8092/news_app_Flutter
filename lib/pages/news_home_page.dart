import 'package:flutter/material.dart';
import 'package:news_app/models/news_item.dart';
import 'package:news_app/news_data.dart';
import 'package:news_app/pages/categories_page.dart';
import 'package:news_app/pages/news_detail_page.dart';
import 'package:news_app/widgets/news_list_view.dart';

class NewsHomePage extends StatefulWidget {
  const NewsHomePage({super.key});

  @override
  _NewsHomePageState createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  int _selectedIndex = 0;
  int _selectedNewsIndex = 0;
  final List<String> categories = [
    'Technology',
    'Sports',
    'Health',
    'Business',
    'Entertainment',
  ];

  final Map<String, List<NewsItem>> newsData = {
    'Technology': List.generate(
        10,
        (index) => NewsItem(
            title: NEWSDATA["Technology"]?[index]["title"] ?? 'No Title',
            description: NEWSDATA["Technology"]?[index]["description"] ??
                'No Description')),
    'Sports': List.generate(
        10,
        (index) => NewsItem(
            title: NEWSDATA["Sports"]?[index]["title"] ?? 'No Title',
            description:
                NEWSDATA["Sports"]?[index]["description"] ?? 'No Description')),
    'Health': List.generate(
        10,
        (index) => NewsItem(
            title: NEWSDATA["Health"]?[index]["title"] ?? 'No Title',
            description:
                NEWSDATA["Health"]?[index]["description"] ?? 'No Description')),
    'Business': List.generate(
        10,
        (index) => NewsItem(
            title: NEWSDATA["Business"]?[index]["title"] ?? 'No Title',
            description: NEWSDATA["Business"]?[index]["description"] ??
                'No Description')),
    'Entertainment': List.generate(
        10,
        (index) => NewsItem(
            title: NEWSDATA["Entertainment"]?[index]["title"] ?? 'No Title',
            description: NEWSDATA["Entertainment"]?[index]["description"] ??
                'No Description')),
  };

  String searchText = "";
  bool issearch = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToCategories(BuildContext context) {
    setState(() {
      _selectedIndex = 1;
    });
  }

  void _onNewsItemTapped(NewsItem newsItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsDetailPage(newsItem: newsItem),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<NewsItem> filteredNewsItems = newsData[categories[_selectedNewsIndex]]!
        .where((newsItem) =>
            newsItem.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
              title: issearch
                  ? TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search...',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                        });
                      },
                    )
                  : const Text("NewsApp"),
              actions: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: !issearch
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                issearch = true;
                              });
                            },
                            icon: const Icon(Icons.search),
                          )
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                issearch = false;
                              });
                            },
                            icon: const Icon(Icons.cancel))),
              ],
            )
          : null,
      body: _selectedIndex == 1
          ? CategoriesPage(
              categories: categories,
              onCategorySelected: (category) {
                setState(() {
                  _selectedNewsIndex = categories.indexOf(category);
                  _selectedIndex = 0;
                });
              })
          : _selectedIndex == 2
              ? const Center(
                  child: Text('PROFILE PAGE'),
                )
              : NewsListView(
                  newsItems: filteredNewsItems,
                  onNewsItemTapped: _onNewsItemTapped,
                ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) {
            _navigateToCategories(context);
          } else {
            _onItemTapped(index);
          }
        },
      ),
    );
  }
}
