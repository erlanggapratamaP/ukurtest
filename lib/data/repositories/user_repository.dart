import 'package:dio/dio.dart';
import 'package:fake_json/data/data.dart';

class UserRepository {
  var dio = Dio(); // with default Options

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
}

class NetworkException implements Exception {}
