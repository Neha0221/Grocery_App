import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceryapp/config.dart';
import 'package:groceryapp/models/category.dart';
import 'package:groceryapp/models/product.dart';
import 'package:groceryapp/models/product_filter.dart';
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
    print('response : $response.statusCode');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print('Data:$data');

      return categoriesFromJson(data["data"]);
    } else {
      return null;
    }
  }

  Future<List<Product>?> getProducts(
    ProductFilterModel productFilterModel,
  ) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    Map<String, String> queryString = {
      'page': productFilterModel.paginationModel.page.toString(),
      'pageSize': productFilterModel.paginationModel.pageSize.toString()
    };

    if (productFilterModel.categoryId != null) {
      queryString['categoryId'] = productFilterModel.categoryId!;
    }
    ;

    if (productFilterModel.sortBy != null) {
      queryString["sort"] = productFilterModel.sortBy!;
    }

    var url = Uri.http(Config.apiURL, Config.productAPI, queryString);
    print('The url:$url');
    var response = await client.get(url, headers: requestHeaders);
    print('response : $response.statusCode');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print('Data:$data');

      return productsFromJson(data["data"]);
    } else {
      return null;
    }
  }
}
