part of 'utilities.dart';

class Api {
  final Dio _dio = Dio();
  Api() {
    updateDioInterceptors();
  }

  void updateDioInterceptors() {
    _dio.options = BaseOptions(
      baseUrl: Commons.getBaseUrl(),
      receiveDataWhenStatusError: true,
      validateStatus: (value) {
        return value! <= 500;
      },
      headers: {
        'Accept': 'application/json',
      },
    );
    _dio
      ..interceptors.add(
        LogInterceptor(
          requestBody: kDebugMode ? true : false,
          responseBody: kDebugMode ? true : false,
          requestHeader: kDebugMode ? true : false,
        ),
      )
      ..interceptors.add(
        InterceptorsWrapper(
          onError: (DioError e, handler) {
            if (e.response?.statusCode == 402) {
              //logout user and go to login page
            }
            return handler.next(e);
          },
        ),
      );
  }

  // requests
  Future<Response> get(String path, {Map<String, dynamic>? param}) async {
    return await _dio.get(path, queryParameters: param);
  }

  Future<Response> post(String path, {Object? data}) async {
    return await _dio.post(path, data: data);
  }
}
