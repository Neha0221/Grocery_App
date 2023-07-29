// import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceryapp/api/api_service.dart';
import 'package:groceryapp/application/notifier/cart_notifier.dart';
import 'package:groceryapp/application/notifier/product_filter_notifier.dart';
import 'package:groceryapp/application/notifier/products_notifier.dart';
import 'package:groceryapp/application/state/cart_state.dart';
import 'package:groceryapp/application/state/product_state.dart';
import 'package:groceryapp/models/category.dart';
import 'package:groceryapp/models/pagination.dart';
import 'package:groceryapp/models/product.dart';
import 'package:groceryapp/models/product_filter.dart';
import 'package:groceryapp/models/slider.dart';

final categoriesProvider =
    FutureProvider.family<List<Category>?, PaginationModel>(
  (ref, paginationModel) {
    final apiRepository = ref.watch(apiService);

    return apiRepository.getCategories(
      paginationModel.page,
      paginationModel.pageSize,
    );
  },
);

final homeProductProvider =
    FutureProvider.family<List<Product>?, ProductFilterModel>(
  (ref, productFilterModel) {
    final apiRepository = ref.watch(apiService);

    return apiRepository.getProducts(productFilterModel);
  },
);

final productsFilterProvider =
    StateNotifierProvider<ProductsFilterNotifier, ProductFilterModel>(
  (ref) => ProductsFilterNotifier(),
);

final productsNotifierProvider =
    StateNotifierProvider<ProductsNotifier, ProductsState>(
        (ref) => ProductsNotifier(
              ref.watch(apiService),
              ref.watch(productsFilterProvider),
            ));

final slidersProvider =
    FutureProvider.family<List<SliderModel>?, PaginationModel>(
  (ref, paginationModel) {
    final sliderRepo = ref.watch(apiService);
    return sliderRepo.getSliders(
      paginationModel.page,
      paginationModel.pageSize,
    );
  },
);

final productDetailsProvider = FutureProvider.family<Product?, String>(
  (ref, productId) {
    final apiRepository = ref.watch(apiService);
    return apiRepository.getProductDetails(productId);
  },
);

final relatedProductsProvider =
    FutureProvider.family<List<Product>?, ProductFilterModel>(
  (ref, productFilterModel) {
    final apiRepository = ref.watch(apiService);
    return apiRepository.getProducts(productFilterModel);
  },
);

final cartItemsProvider = StateNotifierProvider<CartNotifier, CartState>(
  (ref) => CartNotifier(
    ref.watch(apiService),
    ),
);
