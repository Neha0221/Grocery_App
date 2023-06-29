import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/foundation.dart';
import 'package:groceryapp/pages/product_page.dart';
import 'package:groceryapp/pages/register_page.dart';

import 'pages/home_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const RegisterPage(),
      routes:<String,WidgetBuilder>{
      '/register':(BuildContext context) => const RegisterPage (),
      '/products':(BuildContext context) => const ProductsPage()
      },
    );
  }
}
