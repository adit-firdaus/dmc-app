// news_list.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class NewsList extends StatefulWidget {
  final int itemCount;

  const NewsList({super.key, required this.itemCount});

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  List articles = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    const url =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=9d8f7717806c45f3bd18f086ed03e84e';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      // remove that doesn't have an image
      data['articles'].removeWhere((article) => article['urlToImage'] == null);

      setState(() {
        articles = data['articles'].take(widget.itemCount).toList();
      });
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return articles.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return NewsCard(article: article);
            },
          );
  }
}

class NewsCard extends StatelessWidget {
  final Map article;

  const NewsCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      child: Card(
        margin: const EdgeInsets.all(10.0),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              SizedBox(
                width: 128,
                height: 100,
                child: Image.network(
                  article['urlToImage'],
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10.0),
                  title: Text(
                    article['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                  ),
                  subtitle: Text(
                    article['description'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
