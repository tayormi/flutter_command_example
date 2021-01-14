import 'package:dio/dio.dart';
import 'package:flutter_command_example/models/joke_dto.dart';

class ApiService {
  Dio _dio;
  ApiService() {
    _dio = Dio();
  }
  Future<JokeDto> getJoke(String category) async {
    try {
      final response = await _dio
          .get('https://api.chucknorris.io/jokes/random?category=$category');
      final res = JokeDto.fromJson(response.data);
      return res;
    } on DioError catch (e) {
      print(e.error);
      throw e.error;
    }
  }

  Future<List<String>> getCatgories() async {
    try {
      final response =
          await _dio.get('https://api.chucknorris.io/jokes/categories');
      final res = List<String>.from(response.data);
      return res;
    } on DioError catch (e) {
      print(e.error);
      throw e.error;
    }
  }
}
