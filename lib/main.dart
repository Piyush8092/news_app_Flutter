import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:news_app/news_data.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DevicePreview(
        builder: (context) {
          return const NewsHomePage();
        },
      ),
    );
  }
}

// Model class for News
class NewsItem {
  final String title;
  final String description;

  NewsItem({required this.title, required this.description});
}

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
    // Filter news items based on search text
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
                  : Text("NewsApp"),
              actions: [
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: !issearch
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                issearch = true;
                              });
                            },
                            icon: Icon(Icons.search),
                          )
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                issearch = false;
                              });
                            },
                            icon: Icon(Icons.cancel))),
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
              : ListView.builder(
                  itemCount: filteredNewsItems.length,
                  itemBuilder: (context, index) {
                    final newsItem = filteredNewsItems[index];
                    return GestureDetector(
                      onTap: () => _onNewsItemTapped(newsItem),
                      child: Card(
                        elevation: 10,
                        margin: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                newsItem.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                newsItem.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
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

class NewsDetailPage extends StatelessWidget {
  final NewsItem newsItem;

  const NewsDetailPage({super.key, required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(newsItem.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(newsItem.description),
      ),
    );
  }
}
