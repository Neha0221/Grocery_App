import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceryapp/pages/dashboard_page.dart';
import 'package:groceryapp/pages/product_details_page.dart';
import 'package:groceryapp/pages/product_page.dart';
import 'package:groceryapp/pages/register_page.dart';
import 'package:groceryapp/pages/login_page.dart';
import 'package:groceryapp/utils/shared_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

import 'pages/home_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Widget _defaultHome = const LoginPage();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  databaseFactory = databaseFactoryFfiWeb;
  bool _result = await SharedService.isLoggedIn();

  if (_result) {
    _defaultHome = const  HomePage();
  }
  

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      // home: const RegisterPage(),
      navigatorKey: navigatorKey,
      routes: <String, WidgetBuilder>{
         '/': (context) => _defaultHome,
        '/register': (BuildContext context) => const RegisterPage(),
        '/Dashboard': (BuildContext context) => const DashboardPage(),
        '/home': (BuildContext context) => const HomePage(),
        '/login': (BuildContext context) => const LoginPage(),
        '/products': (BuildContext context) => const ProductsPage(),
        '/product-details': (BuildContext context) => const ProductDetailsPage()
      },
    );
  }
}
