import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/secret.dart';

import 'SearchingNewsVariables.dart';


Future<List<Searching>> getSearchResult (String name) async{
  List<Searching> articleList = [];
  var res = await http.get('https://newsapi.org/v2/everything?q=$name&apiKey=$API_KEY');
  var data = json.decode(res.body);
  data['articles'].forEach((element){
    Searching article = Searching(element['author'],element['title'],element['description'],element['url'],element['urlToImage'],element['publishedAt']);
    articleList.add(article);
  });
  return articleList;
}