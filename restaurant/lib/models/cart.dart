import 'dart:collection';

import 'package:flutter/foundation.dart';

class Cart {
  final String id;
  final String title;
  final int number;
  final int price;
  final String imgUrl;

  Cart(
      {required this.id,
      required this.title,
      required this.number,
      required this.price,
      required this.imgUrl});
}

// Class Provider
class CartDataProvider with ChangeNotifier {
  Map<String, Cart> _cartItems = {};

  UnmodifiableMapView<String, Cart> get cartItems =>
      UnmodifiableMapView(_cartItems);

  int get cartItemsCount => _cartItems.length;

  double get totalAmount {
    var total = 0.0;
    _cartItems.forEach((key, item) {
      total += item.price * item.number;
    });
    return total;
  }

  void addItem({productId, price, title, imgUrl}) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (ex) => Cart(
                id: ex.id,
                title: ex.title,
                price: ex.price,
                imgUrl: ex.imgUrl,
                number: ex.number + 1,
              ));
    } else {
      _cartItems.putIfAbsent(
          productId,
          () => Cart(
                id: productId,
                title: title,
                price: price,
                imgUrl: imgUrl,
                number: 1,
              ));
    }
    notifyListeners();
  }

  void deleteItem(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  //Обновление корзины на +1 по id
  void updateItemsAddOne(String productId) {
    _cartItems.update(
      productId,
      (ex) => Cart(
        id: ex.id,
        title: ex.title,
        price: ex.price,
        imgUrl: ex.imgUrl,
        number: ex.number + 1,
      ),
    );
    notifyListeners();
  }

  //Обновление корзины на -1 по id
  void updateItemsSubOne(String productId) {
    if (_cartItems[productId]!.number < 2) {
      deleteItem(productId);
    } else {
      _cartItems.update(productId,
            (ex) =>
            Cart(
              id: ex.id,
              title: ex.title,
              price: ex.price,
              imgUrl: ex.imgUrl,
              number: ex.number - 1,
            ),
      );
    }
      notifyListeners();
    }

//    Очищение корзины
    void clear() {
      _cartItems = {};
      notifyListeners();
    }
  }
