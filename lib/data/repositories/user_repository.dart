import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fake_json/data/data.dart';
import 'package:flutter/services.dart';

class UserRepository extends Interceptor {
  var dio = Dio(); // with default Options
  UserRepository({required this.dio});
// or new Dio with a BaseOptions instance.
  var options = BaseOptions(
    baseUrl: 'https://c50f007f-bad3-4e64-982d-fce35e877b09.mock.pstmn.io',
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  Future<List<User>?> getusers(int page) async {
    Dio dioGet = Dio(options);
    try {
      var response = await dioGet.get(
        '/users',
        options: Options(method: 'GET'),
        queryParameters: {
          'page': page,
        },
      );

      var body = response.data['data']['users'];
      var dataResponse = List.from(body).map((e) => User.fromJson(e)).toList();
      return dataResponse;
    } catch (e) {
      throw NetworkException();
    }
  }

  Future<List<User>?> mockUsers(int page) async {
    try{
      String response =
          await rootBundle.loadString('assets/users_responses.json');

      final result = json.decode(response);
      var body = result[page];
      var data = body['data']['users'];
      var dataResponse = List.from(data).map((e) => User.fromJson(e)).toList();
      return dataResponse;
    } catch (e){
      throw Exception();
    }
   
  }
}

class NetworkException implements Exception {}
