import 'package:flutter/material.dart';
import 'package:news_app/models/news_item.dart';

class NewsListView extends StatelessWidget {
  final List<NewsItem> newsItems;
  final Function(NewsItem) onNewsItemTapped;

  const NewsListView({super.key, required this.newsItems, required this.onNewsItemTapped});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsItems.length,
      itemBuilder: (context, index) {
        final newsItem = newsItems[index];
        return GestureDetector(
          onTap: () => onNewsItemTapped(newsItem),
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
    );
  }
}
