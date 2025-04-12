import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/app/api_servises/api_key.dart';

import '../model/news_model.dart';

class HomeApiServise {
  Future<NewsModel> fetchNews({int page = 1, int pageSize = 20}) async {
    final url = Uri.parse("$baseUrl$apikey&page=$page&pageSize=$pageSize");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return NewsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load news");
    }
  }
}
