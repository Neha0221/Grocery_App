import 'package:flutter/material.dart';
import 'package:groceryapp/components/product_card.dart';
import 'package:groceryapp/models/category.dart';
import 'package:groceryapp/widgets/widget_home_categories.dart';

import '../models/product.dart';
import '../widgets/widgets_home_products.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: ListView(
        children: [
          const HomeCategoriesWidget(), 
          const HomeProductsWidget()
          // ProductCard(
          //   model: model,
          // )
          ],
      )),
    );
  }
}
