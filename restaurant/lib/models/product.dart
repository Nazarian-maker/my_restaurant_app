import 'dart:collection';
import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final num price;
  final String imgUrl;
  final color;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imgUrl,
      required this.color});
}

class ProductDataProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: '1',
      title: 'Биг Хит',
      description: 'Бургер с двумя бифштексами и т.д.',
      price: 166.99,
      imgUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUf2ez101D52qP1yId59ONKsbwpEB6uO4mUA&usqp=CAU',
      color: '0xFFFFC107',
    ),
    Product(
      id: '2',
      title: 'Биг Смоук',
      description: 'Бургер с двумя бифштексами и т.д.',
      price: 186.99,
      imgUrl:
      'https://cdn.bahroma1.ru/goods/grandburger_6366d239d48cc.jpg',
      color: '0xFFFFC107',
    ),
    Product(
      id: '3',
      title: 'Биг Хит',
      description: 'Бургер с двумя бифштексами и т.д.',
      price: 166.99,
      imgUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUf2ez101D52qP1yId59ONKsbwpEB6uO4mUA&usqp=CAU',
      color: '0xFFFFC107',
    ),
    Product(
      id: '4',
      title: 'Биг Смоук',
      description: 'Бургер с двумя бифштексами и т.д.',
      price: 186.99,
      imgUrl:
      'https://cdn.bahroma1.ru/goods/grandburger_6366d239d48cc.jpg',
      color: '0xFFFFC107',
    ),
    Product(
      id: '5',
      title: 'Биг Хит',
      description: 'Бургер с двумя бифштексами и т.д.',
      price: 166.99,
      imgUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUf2ez101D52qP1yId59ONKsbwpEB6uO4mUA&usqp=CAU',
      color: '0xFFFFC107',
    ),
  ];

  UnmodifiableListView<Product> get items => UnmodifiableListView(_items);

  Product getElementById(String id) =>
      _items.singleWhere((value) => value.id == id);
}


