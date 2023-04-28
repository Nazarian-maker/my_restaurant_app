// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getOrder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as int?,
      num: json['num'] as String?,
      count: json['count'] as int?,
      total_cost: json['total_cost'] as int?,
      is_closed: json['is_closed'] as bool,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'num': instance.num,
      'count': instance.count,
      'total_cost': instance.total_cost,
      'is_closed': instance.is_closed,
    };
