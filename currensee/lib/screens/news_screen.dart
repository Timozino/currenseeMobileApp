import 'package:flutter/material.dart';
import 'package:currensee/services/news_service.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final NewsService _newsService = NewsService();
  List<dynamic> _newsArticles;

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  void _fetchNews() async {
    try {
      List<dynamic> news = await _newsService.fetchNews('currency');
      setState(() {
        _newsArticles = news;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency News'),
      ),
      body: _newsArticles == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _newsArticles.length,
              itemBuilder: (context, index) {
                var article = _newsArticles[index];
                return ListTile(
                  title: Text(article['title']),
                  subtitle: Text(article['description']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailScreen(article: article),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}