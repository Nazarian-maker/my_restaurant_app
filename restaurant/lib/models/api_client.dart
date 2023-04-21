import 'dart:convert';
import 'dart:io';

class ApiClient {
  final _client = HttpClient();

  Future<String> validateUser({
    required String email,
    required String password,
  }) async {

    final url = Uri.parse('http://laravel-rest.ru/api/login');
    final parameters = <String, dynamic> {
      'email': email,
      'password': password,
    };
    final request = await _client.postUrl(url);

    request.headers.contentType = ContentType.json;

    request.write(jsonEncode(parameters));

    final response = await request.close();

    final json = await response
    .transform(utf8.decoder)
    .toList()
    .then((value) => value.join())
    .then((v) => jsonDecode(v) as Map<String, dynamic>);

    final token = json['access_token'] as String;

    return token;
  }

  Future<String> validateUserPin({
    required String pinText,
  }) async {

    final numPin = int.parse(pinText);
    final url = Uri.parse('http://laravel-rest.ru/api/login');
    final parameters = <String, dynamic> {
      'pin_code': numPin,
    };
    final request = await _client.postUrl(url);

    request.headers.contentType = ContentType.json;

    request.write(jsonEncode(parameters));

    final response = await request.close();

    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as Map<String, dynamic>);

    final token = json['access_token'] as String;

    return token;
  }

  Future<String> userLogout({
    required String? userToken,
  }) async {
    final url = Uri.parse('http://laravel-rest.ru/api/logout');
    final request = await _client.postUrl(url);

    request.headers.set('Authorization', 'Bearer $userToken');
    final response = await request.close();

    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as Map<String, dynamic>);


    final responseMessage = json['message'] as String;

    return responseMessage;
  }

  Future<String> forgotPassword({
    required String userEmail,
  }) async {

    final url = Uri.parse('http://laravel-rest.ru/api/forgot-password');
    final parameters = <String, dynamic> {
      'email': userEmail,
    };
    final request = await _client.postUrl(url);

    request.headers.contentType = ContentType.json;

    request.write(jsonEncode(parameters));

    final response = await request.close();

    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as Map<String, dynamic>);

    final message = json['message'] as String;

    return message;
  }

  Future<String> passwordPinConfirmation({
    required String pasPin,
  }) async {
    final numPin = int.parse(pasPin);
    final url = Uri.parse('http://laravel-rest.ru/api/pincode-confirmation');
    final parameters = <String, dynamic> {
      'pin_code': numPin,
    };
    final request = await _client.postUrl(url);

    request.headers.contentType = ContentType.json;

    request.write(jsonEncode(parameters));

    final response = await request.close();

    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as Map<String, dynamic>);

    final message = json['message'] as String;

    return message;
  }

  Future<String> newUserPass({
    required String mail,
    required String pass,
    required String newPass
  }) async {

    final url = Uri.parse('http://laravel-rest.ru/api/reset-password');
    final parameters = <String, dynamic> {
      'email': mail,
      'password': pass,
      'password_confirmation': newPass,
    };
    final request = await _client.postUrl(url);

    request.headers.contentType = ContentType.json;

    request.write(jsonEncode(parameters));

    final response = await request.close();

    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as Map<String, dynamic>);

    final message = json['message'] as String;

    return message;
  }
}

//dod300@yandex.ru
