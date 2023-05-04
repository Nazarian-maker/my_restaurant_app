import 'package:flutter/cupertino.dart';

import '../../server/api_client.dart';
import '../auth_login.dart';

class OrderChanges extends ChangeNotifier {
  final _apiClient = ApiClient();
  final session = AuthLogin().session;

  static int? orderId;
  static int? productId;

  int? getOrder(int? order) {
    orderId = order;
    return orderId;
  }

  int? getProduct(int? product) {
    productId = product;
    return productId;
  }

  Future<void> addOne() async {
    final message = await _apiClient.addToOrder(
        token: session, dishId: productId, orderId: orderId);
    print(message);
    notifyListeners();
  }

  Future<void> subOne() async {
    final message = await _apiClient.subToOrder(
        token: session, dishId: productId, orderId: orderId);
    print(message);
    notifyListeners();
  }

  Future<void> close() async {
    final message =
        await _apiClient.closeOrder(token: session, orderId: orderId);
    print(message);
    notifyListeners();
  }
}
