import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  final int id;
  final String name;
  final String image;
  final String url;
  final DateTime created_at;
  final DateTime updated_at;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.url,
    required this.created_at,
    required this.updated_at,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
