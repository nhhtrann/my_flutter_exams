import 'package:flutter/material.dart';
import '../api/news_api.dart';
import '../models/news.dart';
import 'news_detail.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tin tức")),
      body: FutureBuilder(
        future: newsApi.getNews(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          List<News> list = snapshot.data!;

          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, i) {
              var item = list[i];
              return ListTile(
                leading: Image.network(item.thumbnail, width: 60, height: 60),
                title: Text(item.title),
                subtitle: Text(item.description),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NewsDetailScreen(news: item),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
