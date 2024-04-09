import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:practice/model/catergory_model.dart';
import 'package:practice/model/news_headline_json.dart';
import 'package:http/http.dart' as http;
import 'package:practice/home_screen/home_screen.dart';

class apiRepository {
  Future<newsHeadlines> headline(String channelName) async {


    String url =
        "https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=eae97c329fb24cbb8864914534a9e04d";

    final response = await http.get(Uri.parse(url));

    if (kDebugMode) {
      print(response.body);
    }

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      return newsHeadlines.fromJson(body);
    } else {
      throw Exception("error");
    }
  }


  Future<categoryModel> category(String category) async {
    String url = "https://newsapi.org/v2/everything?q=${category}&apiKey=eae97c329fb24cbb8864914534a9e04d";

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      final body = jsonDecode(response.body);

      return categoryModel.fromJson(body);
    }else{
      throw Exception("error");
    }

  }

}
