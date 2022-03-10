import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/secret.dart';

import 'GetCategoryNewsVariables.dart';

Future<List<ArticleCategory>> getCategoryNew(String name) async {
  List<ArticleCategory> articleList = [];
  http.Response res = await http.get(
      'https://newsapi.org/v2/top-headlines?category=$name&country=in&apiKey=$API_KEY');
  var data = json.decode(res.body);
  data['articles'].forEach((element) {
    if (element['urlToImage'] != null) {
      ArticleCategory article = ArticleCategory(
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
