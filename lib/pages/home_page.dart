import 'package:flutter/material.dart';
// import 'package:groceryapp/models/components/product_card.dart';
import 'package:groceryapp/widgets/widget_home_categories.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: ListView(
        children: [
          const HomeCategoriesWidget(),
          //const ProductCard()
        ],
      )),
    );
  }
}
