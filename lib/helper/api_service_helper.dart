import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:transisi/helper/my_helper.dart';
import 'constants.dart';

class ApiServiceHelper {
  dynamic service(
    data,
    method,
    path,
    onSuccess,
    onFailure,
    onNoInternetConnection,
  ) async {
    if (await MyHelpers.checkConnection()) {
      try {
        Dio dio = Dio();
        Options header = Options(
          receiveTimeout: 60000,
          sendTimeout: 60000,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        );

        String url = "${Constants.BASE_URL}$path";
        dynamic response;

        switch (method) {
          case Constants.METHOD_TYPE_POST:
            response = await dio.post(
              url,
              data: data,
              options: header,
            );
            break;
          case Constants.METHOD_TYPE_GET:
            response = await dio.get(
              url,
              queryParameters: data,
              options: header,
            );
            break;
          default:
            throw Exception({"error": "Method Not Valid", "code": 403});
        }
        onSuccess(response.data, response.statusCode);
        if (kDebugMode) {
          log("response ${response.statusCode} : ${response.data.toString()}");
        }
      } on DioError catch (e) {
        if (e.response != null) {
          onFailure(e.response!.data, e.response!.statusCode);
          if (kDebugMode) {
            log("response ${e.response!.statusCode} : ${e.response!.data.toString()}");
          }
        } else {
          if (e.type == DioErrorType.receiveTimeout ||
              e.type == DioErrorType.connectTimeout) {
            onFailure({"error": Constants.TIMEOUT}, 408);
          } else {
            onFailure({"error": Constants.ERROR_SERVER}, 500);
          }
        }
      } catch (e) {
        onFailure({"error": "Method Not Allowed"}, 403);
      }
    } else {
      onNoInternetConnection();
    }
  }
}
