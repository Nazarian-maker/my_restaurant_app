import 'package:flutter/material.dart';
import 'package:restaurant/models/product/product.dart';

import '../../server/api_client.dart';

class ProductList extends ChangeNotifier {
  final _apiClient = ApiClient();

  final int categoryId;
  final _product = <Product>[];

  List<Product> get product => _product;

  ProductList({required this.categoryId});

  Future<void> loadDishes() async {
    final productResponse = await _apiClient.fetchDishes(categoryId: categoryId);
    _product.addAll(productResponse);
    notifyListeners();

  }
}