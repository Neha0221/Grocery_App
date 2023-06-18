import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceryapp/config.dart';
import 'package:groceryapp/models/category.dart';
import 'package:http/http.dart' as http;

final apiService = Provider((ref) => APIService());

class APIService {
  static var client = http.Client();
  Future<List<Category>?> getCategories(page, pageSize) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    Map<String, String> queryString = {
      'page': page.toString(),
      'pageSize': pageSize.toString()
    };

    var url = Uri.http(Config.apiURL, Config.categoryAPI, queryString);
    print('The url:$url');
    var response = await client.get(url, headers: requestHeaders);
      //  http.Response response;
      //   response =
      //   await http.get(Uri.parse("http://192.168.57.156:4000/api/category"));
    print('response : $response.statusCode');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print('Data:$data');

      return categoriesFromJson(data["data"]);
    } else {
      return null;
    }
  }
}
