import 'package:flutter/material.dart';
import 'package:restaurant/models/auth_login.dart';
import 'package:restaurant/models/users/users.dart';
import '../../server/api_client.dart';

class UsersList extends ChangeNotifier {
  final _apiClient = ApiClient();
  final session = AuthLogin().session;

  final _users = <Users>[];
  List<Users> get users => _users;


  Future<void> loadUsers() async {
    final usersResponse = await _apiClient.getUsers(userToken: session);
    _users.addAll(usersResponse);
    notifyListeners();
  }
}
