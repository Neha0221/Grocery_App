// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceryapp/components/product_card.dart';
import 'package:groceryapp/models/category.dart';
import 'package:groceryapp/models/product.dart';
import 'package:groceryapp/models/product_filter.dart';
import 'package:groceryapp/providers.dart';

import '../models/pagination.dart';

class HomeProductsWidget extends ConsumerWidget {
  const HomeProductsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // List<Product> list = List<Product>.empty(growable: true);
    // list.add(Product(
    //   productName: "OREO",
    //   category: Category(
    //       categoryName: "Snacks",
    //       categoryImage: "/uploads/categories/1687263480049-Snacks.png",
    //       categoryId: "649198f84da4f52b328286a2"),
    //   productShortDescription: "Oreo cadbury dipped choco",
    //   productPrice: 250,
    //   productSalePrice: 200,
    //   productImage: "/uploads/products/1687435394738-oreo.png",
    //   productSKU: "123",
    //   productType: "simple",
    //   stockStatus: "IN",
    //   productId: "649438826c6a890553ee3647",
    // ));
    return Container(
      color: const Color(0xffF4F7FA),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 15),
              child: Text(
                "TOP 10 Products",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: _productsList(ref),
        )
      ]),
    );
  }

  Widget _productsList(WidgetRef ref) {
    final products = ref.watch(homeProductProvider(ProductFilterModel(
      paginationModel: PaginationModel(page: 1, pageSize: 10),
    )));

    return products.when(
        data: (list) {
          return _buildProductList(list!);
        },
        error: (err1, err2) {
          print(err1);
          return Center(
            child: Text("$err1+$err2+ERR in _categoriesList "),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()
        )
        );
  }

  Widget _buildProductList(List<Product> products) {
    return Container(
      height: 200,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          var data = products[index];
          return GestureDetector(
            onTap: () {},
            child: ProductCard(
              model: data,
            ),
          );
        },
      ),
    );
  }
}
