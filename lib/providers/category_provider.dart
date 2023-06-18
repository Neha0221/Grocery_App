// import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceryapp/api/api_service.dart';
import 'package:groceryapp/models/category.dart';
import 'package:groceryapp/models/pagination.dart';

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
