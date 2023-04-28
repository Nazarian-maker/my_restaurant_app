import 'dart:async';
import 'package:restaurant/models/category.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/server/api_client.dart';

class CategoryList extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _categories = <Category>[];
  List<Category> get categories => _categories;

  Future<void> loadCategories() async {
    final categoriesResponse = await _apiClient.fetchCategories();
    _categories.addAll(categoriesResponse);
    notifyListeners();
  }

  void onCategoryTap(BuildContext context, int index, name) {
    final id = _categories[index].id;
    Navigator.of(context).pushNamed('/category_page/category_menu', arguments: [id, name]);
  }
}