import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/home_page_modules/data.dart';
import 'package:newsapp/secret.dart';

Future<dynamic> getNewsData() async {
  List<Article> articleList = [];
  var res = await http
      .get('https://newsapi.org/v2/top-headlines?country=in&apiKey=$API_KEY');
  var data = json.decode(res.body);
  data['articles'].forEach((element) {
    if (element['urlToImage'] != null) {
      Article article = Article(
          element['author'],
          element['title'],
          element['description'],
          element['url'],
          element['urlToImage'],
          element['publishedAt']);
      articleList.add(article);
    }
  });
  return articleList;
}
