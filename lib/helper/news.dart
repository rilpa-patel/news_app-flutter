import 'dart:convert';

import 'package:news_app/models/article_model.dart';
import 'package:http/http.dart' as http;

class News{
  List<ArticleModel> news = [];

  Future<void> getNews() async{
    String url ="https://newsapi.org/v2/top-headlines?country=in&apiKey=6cac071787364d40a0138fd1225782ba";

    var response = await http.get(Uri.parse(url));;
    var jshonData = jsonDecode(response.body);
    if(jshonData['status'] == "ok"){
      jshonData['articles'].forEach((element){
        if(element["urlToImage"] != null && element["description"] != null ){
          ArticleModel articleModel= ArticleModel(
            title: element['title'],
            // author: element['author'],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],

          ) ;

          news.add(articleModel);
        }
      });
    }
  }
}

class Categorynews{
  List<ArticleModel> news = [];

  Future<void> getNews(String category) async{
    String url ="https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=6cac071787364d40a0138fd1225782ba";

    var response = await http.get(Uri.parse(url));;
    var jshonData = jsonDecode(response.body);
    if(jshonData['status'] == "ok"){
      jshonData['articles'].forEach((element){
        if(element["urlToImage"] != null && element["description"] != null ){
          ArticleModel articleModel= ArticleModel(
              title: element['title'],
              // author: element['author'],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],

          ) ;

          news.add(articleModel);
        }
      });
    }
  }
}