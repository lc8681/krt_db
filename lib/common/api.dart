import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:krt_db/configs.dart';
import 'package:krt_db/common/tools.dart';

class Api {
  static Dio dio = Dio(BaseOptions(
    baseUrl: APP_HOST,
    connectTimeout: API_TIMEOUT,
    receiveTimeout: API_RECEIVE_TIMEOUT,
    responseType: ResponseType.plain,
  ));

  static InterceptorsWrapper _interceptorsWrapper = InterceptorsWrapper(
    onRequest: (RequestOptions options) {
      isNetworkConnect().then((value) {
        if (!value) {
          showToast('Network not connected !');
        }
      });
      return options;
    },
    onResponse: (Response response) {
      return response; // continue
    },
    onError: (DioError e) {
      dio.close();
      return e; //continue
    },
  );

  static init() {
    if (!dio.interceptors.contains(_interceptorsWrapper)) {
      dio.interceptors.add(_interceptorsWrapper);
    }
  }

  static queryUsersData(Map parameters) {
    init();
    return dio.get("/search/users", queryParameters: parameters);
  }
}
