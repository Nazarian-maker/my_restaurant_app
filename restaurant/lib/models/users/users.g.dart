// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Users _$UsersFromJson(Map<String, dynamic> json) => Users(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      pin_code: json['pin_code'] as int?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'pin_code': instance.pin_code,
      'password': instance.password,
    };
