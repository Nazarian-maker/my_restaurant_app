import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/models/api_client.dart';
import 'package:restaurant/models/session_data_provider.dart';

class AuthLogin extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();

  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final pinTextController = TextEditingController();
  final mailTextController = TextEditingController();
  final mailPinTextController = TextEditingController();

  var pinText;
  late String userMail;
  static String? sessionId;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get canAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;

    if (login.isEmpty || password.isEmpty) {
      _errorMessage = 'Заполните email и пароль!';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();

    try {
      sessionId =
          await _apiClient.validateUser(email: login, password: password);
    } catch (e) {
      _errorMessage = 'Неправильный email или пароль!';
    }

    _isAuthProgress = false;
    if (_errorMessage != null) {
      notifyListeners();
      return;
    }

    if (sessionId == null) {
      _errorMessage = 'Неизвестная ошибка, повторите попытку';
      notifyListeners();
      return;
    }
    await _sessionDataProvider.setSessionId(sessionId!);
    unawaited(Navigator.of(context)
        .pushNamedAndRemoveUntil('/home', (route) => false));
  }

  Future<void> authPin(BuildContext context) async {
    final pin = pinText;

    if (pin == null) {
      _errorMessage = 'Вы не ввели пинкод!';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();

    try {
      sessionId = await _apiClient.validateUserPin(pinText: pinText);
    } catch (e) {
      _errorMessage = 'Неправильный пинкод!';
    }

    _isAuthProgress = false;
    if (_errorMessage != null) {
      notifyListeners();
      return;
    }

    if (sessionId == null) {
      _errorMessage = 'Неизвестная ошибка, повторите попытку';
      notifyListeners();
      return;
    }
    await _sessionDataProvider.setSessionId(sessionId!);
    unawaited(Navigator.of(context)
        .pushNamedAndRemoveUntil('/home', (route) => false));
  }

  Future<void> userExit(BuildContext context) async {
    String? message;

    try {
      message = await _apiClient.userLogout(userToken: sessionId);
    } catch (e) {
      print('errors in logout');
    }
    sessionId == null;

    notifyListeners();
    unawaited(Navigator.of(context)
        .pushNamedAndRemoveUntil('/auth', (route) => false));
  }

  Future<void> userPassForgot(BuildContext context) async {
    userMail = mailTextController.text;
    String? message;

    try {
      message = await _apiClient.forgotPassword(userEmail: userMail);
    } catch (e) {
      print('Ошибка сброса пароля');
    }
    print(message);
    notifyListeners();
  }

  Future<void> passwordPin(BuildContext context) async {
    final pin = mailPinTextController.text;
    String? message;

    try {
      message = await _apiClient.passwordPinConfirmation(pasPin: pin);
    } catch (e) {
      print('jopa');
    }
    print('jopa');
    print(message);
    notifyListeners();
  }
}

class AuthProvider extends InheritedNotifier {
  final AuthLogin model;

  const AuthProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, notifier: model, child: child);

  static AuthProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthProvider>();
  }

  static AuthProvider? read(BuildContext context) {
    final widget =
        context.getElementForInheritedWidgetOfExactType<AuthProvider>()?.widget;
    return widget is AuthProvider ? widget : null;
  }
}
