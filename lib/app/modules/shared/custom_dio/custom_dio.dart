import 'package:dio/dio.dart';
import 'package:dio_app/app/modules/shared/custom_dio/interceptors.dart';

import '../constants.dart';

class CustomDio {
  final Dio dio;

  CustomDio(this.dio){
    dio.options.baseUrl = BASE_URL;
    dio.interceptors.add(CustomInterceptors());
  }

}