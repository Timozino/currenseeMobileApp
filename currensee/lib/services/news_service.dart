import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsService {
  final String apiUrl = "https://newsapi.org/v2/everything";
  final String apiKey = "YOUR_NEWSAPI_KEY";

  Future<List<dynamic>> fetchNews(String query) async {
    final response = await http.get(Uri.parse("$apiUrl?q=$query&apiKey=$apiKey"));

    if (response.statusCode == 200) {
      return json.decode(response.body)['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }
}