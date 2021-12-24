import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:heleapp/app/app_prefs.dart';
import 'package:heleapp/app/constant.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORISATION = "Authorisation";
const String DEFAULT_LANGUAGE = "language";

class DioFactory {
  AppPrefrences _appPrefrences;
  DioFactory(this._appPrefrences);
  Future<Dio> getDio() async {
    Dio dio = Dio();
    int _timeOut = 60 * 1000;
    String language = await _appPrefrences.getAppLanguage();
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORISATION: Constant.token,
      DEFAULT_LANGUAGE: language,
    };
    dio.options = BaseOptions(
        baseUrl: Constant.baseUrl,
        connectTimeout: _timeOut,
        receiveTimeout: _timeOut,
        headers: headers);

    if (kReleaseMode) {
      print("release mode no logs");
    } else {
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true));
    }
    return dio;
  }
}