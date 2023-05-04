import 'dart:convert';
import 'dart:io';
import 'package:restaurant/models/category/category.dart';
import 'package:restaurant/models/orders/getOrder.dart';
import 'package:restaurant/models/product/product.dart';

class ApiClient {
  final _client = HttpClient();

  //-----------------------------------------Orders----------------------------------

  Future<String> closeOrder({
    required String? token,
    required int? orderId,
  }) async {

    final url = Uri.parse('http://laravel-rest.ru/api/orders/$orderId/close');

    final request = await _client.putUrl(url);

    request.headers.contentType = ContentType.json;

    request.headers.add('Authorization', 'Bearer $token');

    final response = await request.close();

    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as Map<String, dynamic>);

    final message = json['message'] as String;

    return message;
  }

  Future<String> subToOrder({
    required String? token,
    required int? dishId,
    required int? orderId,
  }) async {

    final url = Uri.parse('http://laravel-rest.ru/api/orders/$dishId/$orderId/delete');

    final parameters = <String, dynamic>{
      'count': 1,
    };

    final request = await _client.putUrl(url);

    request.headers.contentType = ContentType.json;

    request.headers.add('Authorization', 'Bearer $token');

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

  Future<String> addToOrder({
    required String? token,
    required int? dishId,
    required int? orderId,
  }) async {

    final url = Uri.parse('http://laravel-rest.ru/api/orders/$dishId/$orderId');

    final parameters = <String, dynamic>{
      'count': 1,
    };

    final request = await _client.postUrl(url);

    request.headers.contentType = ContentType.json;

    request.headers.add('Authorization', 'Bearer $token');

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

  Future<String> createOrder({
    required int waiter,
    required String? userToken,
  }) async {
    final url = Uri.parse('http://laravel-rest.ru/api/orders');
    final parameters = <String, dynamic>{
      'waiter_id': waiter,
    };
    final request = await _client.postUrl(url);

    request.headers.contentType = ContentType.json;

    request.headers.add('Authorization', 'Bearer $userToken');

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

  Future<List<Order>> getOrders({
  required String? userToken
}) async {
    final url = Uri.parse('http://laravel-rest.ru/api/orders');
    final request = await _client.getUrl(url);

    request.headers.contentType = ContentType.json;

    request.headers.add('Authorization', 'Bearer $userToken');

    final response = await request.close();

    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString) as List<dynamic>;

    final orders = json
        .map((dynamic e) => Order.fromJson(e as Map<String, dynamic>))
        .toList();

    return orders;
  }

  //-----------------------------------------Category----------------------------------

  Future<List<Category>> fetchCategories() async {
    final url = Uri.parse('http://laravel-rest.ru/api/categories');
    final request = await _client.getUrl(url);
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString) as List<dynamic>;
    final categories = json
        .map((dynamic e) => Category.fromJson(e as Map<String, dynamic>))
        .toList();
    return categories;
  }

  //-----------------------------------------Dishes----------------------------------

  Future<List<Product>> fetchDishes({
    required int categoryId,
  }) async {
    final url =
        Uri.parse('http://laravel-rest.ru/api/dishes/?category_id=$categoryId');
    final request = await _client.getUrl(url);
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString) as List<dynamic>;
    final dishes = json
        .map((dynamic e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();
    return dishes;
  }

  //--------------------------------------------Auth--------------------------------------

  Future<String> validateUser({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('http://laravel-rest.ru/api/login');
    final parameters = <String, dynamic>{
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
    final parameters = <String, dynamic>{
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
    final parameters = <String, dynamic>{
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
    final parameters = <String, dynamic>{
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

  Future<String> newUserPass(
      {required String mail,
      required String pass,
      required String newPass}) async {
    final url = Uri.parse('http://laravel-rest.ru/api/reset-password');
    final parameters = <String, dynamic>{
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
