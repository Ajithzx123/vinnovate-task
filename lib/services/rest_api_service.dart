import 'dart:developer';

import 'package:dio/dio.dart';

enum TheResponseType {
  list,
  map,
}

Future<Response> apiCallService(
  String endpoint,
  String method,
) async {
  final dio = Dio();
  final url = "https://fakestoreapi.com/$endpoint";

  late Response response;
  try {
    if (method == 'GET') {
      response = await dio.get(url);

      // else every method
    }
    return response;
  } on DioException catch (e) {
    log(e.response!.data);
  } finally {}
  return response;
}
