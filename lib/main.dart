import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:news_app/news_data.dart';
import 'package:news_app/pages/news_home_page.dart';

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
        isToolbarVisible: false,
        builder: (context) => const NewsHomePage(),
      ),
    );
  }
}
