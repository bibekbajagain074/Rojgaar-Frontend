import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get.dart';
import '../../utils/api_endpoints.dart';
import '../../views/utils/no_network.dart';
import 'app_controller.dart';

enum RequestType {
  get,
  getWithToken,
  post,
  postWithToken,
  postWithTokenFormData,
  postWithTokenFormDataWithList,
  postFilesWithTokenFormData,
  postWithHeaders,
  postWithFormData
}

class DioClient {
  final dio = Dio();

  Future post(
      {required String url, dynamic data, bool requiresToken = false}) async {
    return await dio.post(url,
        data: data,
        options: Options(
            headers: (requiresToken)
                ? {
                    "Authorization":
                        "Bearer ${await Get.find<AppController>().retrieveAccessToken()}"
                  }
                : null,
            validateStatus: (status) {
              return status! <= 500;
            }));
  }

  Future put(
      {required String url, dynamic data, bool requiresToken = false}) async {
    return await dio.put(url,
        data: data,
        options: Options(
            headers: (requiresToken)
                ? {
              "Authorization":
              "Bearer ${await Get.find<AppController>().retrieveAccessToken()}"
            }
                : null,
            validateStatus: (status) {
              return status! <= 500;
            }));
  }

  Future get({required url, bool requiresToken = false}) async {
    return await dio.get(url,
        options: Options(
            headers: (requiresToken)
                ? {
                    "Authorization":
                        "Bearer ${await Get.find<AppController>().retrieveAccessToken()}"
                  }
                : null,
            validateStatus: (status) {
              return status! <= 500;
            }));
  }

  bool checkResponse({required request}) {
    if (request.statusCode == 500) {
      debugPrint('>> invalid credentials');
      // throw 'Invalid credentials!';
    } else if (request.statusCode != 200) {
      debugPrint(
          '>> status code error: ${request.statusCode}\n>> response: ${request.data.toString()}');
      // throw request.statusCode.toString();
    } else if (request.data == null || request.data.runtimeType == String) {
      debugPrint('>> response error');
      // throw "Couldn't login at the moment, please try again later.";
    } else {
      return true;
    }
    return false;
  }
}
