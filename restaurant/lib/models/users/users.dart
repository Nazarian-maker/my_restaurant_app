import 'package:json_annotation/json_annotation.dart';

part 'users.g.dart';

@JsonSerializable()
class Users {
  final int? id;
  final String? name;
  final String? email;
  final int? pin_code;
  final String? password;

  Users({
    required this.id,
    required this.name,
    required this.email,
    required this.pin_code,
    required this.password,
});

  factory Users.fromJson(Map<String, dynamic> json) =>
      _$UsersFromJson(json);
  Map<String, dynamic> toJson() => _$UsersToJson(this);
}