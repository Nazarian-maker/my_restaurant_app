import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product with ChangeNotifier {
  final int id;
  final String name;
  final String url;
  final String composition;
  final int calories;
  final int cost;
  final int category_id;
  final DateTime created_at;
  final DateTime updated_at;

  Product({
    required this.id,
    required this.name,
    required this.url,
    required this.composition,
    required this.calories,
    required this.cost,
    required this.category_id,
    required this.created_at,
    required this.updated_at,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
