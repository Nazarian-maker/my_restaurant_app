import 'package:flutter/material.dart';
import 'package:restaurant/models/auth_login.dart';
import 'package:restaurant/models/getOrder.dart';
import '../server/api_client.dart';

class OrdersList  extends ChangeNotifier {
  final _apiClient = ApiClient();
  final session = AuthLogin().session;

  final _orders = <Order>[];

  List<Order> get orders => _orders;

  Future<void> showOrders() async {
    final ordersResponse = await _apiClient.getOrders(userToken: session);
    _orders.addAll(ordersResponse);
    notifyListeners();
  }
}