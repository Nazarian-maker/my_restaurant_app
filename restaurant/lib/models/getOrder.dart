import 'package:json_annotation/json_annotation.dart';

part 'getOrder.g.dart';

@JsonSerializable()
class Order {
  final int? id;
  final String? num;
  final int? count;
  final int? total_cost;
  final bool is_closed;

  Order({
    required this.id,
    required this.num,
    required this.count,
    required this.total_cost,
    required this.is_closed,
  });

  factory Order.fromJson(Map<String, dynamic> json) =>
      _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
