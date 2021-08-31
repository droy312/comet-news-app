import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../service_locator.dart';

abstract class NewsApiService {
  Future<Map<String, dynamic>> getData(String url);
}

class NewsApiServiceImpl extends NewsApiService {
  final Dio dio = sl<Dio>();

  Future<Map<String, dynamic>> getData(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      final Response response = await dio.getUri(
        uri,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: dotenv.env['APIKEY'],
          },
        ),
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      print('ERRORRR: $e');
      throw Exception();
    }
  }
}
