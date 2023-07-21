import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceryapp/config.dart';
import 'package:groceryapp/models/category.dart';
import 'package:groceryapp/models/login_response_model.dart';
import 'package:groceryapp/models/product.dart';
import 'package:groceryapp/models/product_filter.dart';
import 'package:groceryapp/models/slider.dart';
import 'package:groceryapp/utils/shared_service.dart';
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

    if (productFilterModel.productIds != null) {
      queryString["productIds"] = productFilterModel.productIds!.join(",");
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

  static Future<bool> registerUser(
    String fullName,
    String email,
    String password,
  ) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, Config.registerAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {"fullName": fullName, "email": email, "password": password},
      ),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> loginUser(
    String email,
    String password,
  ) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, Config.loginAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {"email": email, "password": password},
      ),
    );
    if (response.statusCode == 200) {
      // await SharedService.setLoginDetails(loginResponseJson(response.body));
      return true;
    } else {
      return false;
    }
  }

  Future<List<SliderModel>?> getSliders(page, pageSize) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    Map<String, String> queryString = {
      'page': page.toString(),
      'pageSize': pageSize.toString()
    };

    var url = Uri.http(Config.apiURL, Config.sliderAPI, queryString);

    print('url : ${url}');
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return slidersFromJson(data["data"]);
    } else {
      return null;
    }
  }

  Future<Product?> getProductDetails(String productId) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    Map<String, String> hm = new Map();
    hm["id"] = productId;
    var url = Uri.http(Config.apiURL, Config.productAPI +"/"+ productId);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return Product.fromJson(data["data"]);
    } else {
      return null;
    }
  }
}
