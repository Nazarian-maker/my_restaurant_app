import 'dart:convert';
import 'dart:io';
// import 'package:http/http.dart' as http;

class ApiClient {
  final _client = HttpClient();

  Future<String> auth({
  required String email,
    required String password
}) async {
    final token = await validateUser(email: email, password: password);
    return token;
  }

  Future<String> validateUser({
    required String email,
    required String password,
  }) async {
    // final parameters = {'email': 'dod300@yandex.ru', 'password': '12345678'};

    // final response = await http.post(
    //   Uri.parse('http://laravel-rest.ru/api/login'),
    //   body: jsonEncode(parameters),
    //   headers: {'Content-Type': 'application/json',
    //   'Accept': 'application/json'},
    // );
    //
    // final json = jsonDecode(response.body) as Map<String, dynamic>;
    //
    // if (response.statusCode == 200) {
    //   final token = json as String;
    //   print('this is ${json}');
    //   return token;
    // }
    //   return 'Ошибка';

    final url = Uri.parse('http://laravel-rest.ru/api/login');
    final parameters = <String, dynamic> {
      'email': email,
      'password': password
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
}
