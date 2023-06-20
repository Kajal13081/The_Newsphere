import 'package:dio/dio.dart';
import 'endpoints.dart';


class DioClient {
  static BaseOptions options = new BaseOptions(
    baseUrl: Endpoints.baseUrl,
    connectTimeout: Duration(seconds: Endpoints.connectionTimeout),
    receiveTimeout: Duration(seconds: Endpoints.receiveTimeout),
  );
  Dio _dio = Dio(options);

  Future<dynamic> get(
      String uri, {
        required Map<String, dynamic> queryParameters,
        required Options options,
        required CancelToken cancelToken,
        required ProgressCallback onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> post(
      String uri, {
        data,
        required Map<String, dynamic> queryParameters,
        required Options options,
        required CancelToken cancelToken,
        required ProgressCallback onSendProgress,
        required ProgressCallback onReceiveProgress,
      }) async {
    final Response response = await _dio.post(
      uri,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return response.data;
  }
}