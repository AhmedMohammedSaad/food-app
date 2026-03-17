import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'api_consumer.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = "https://api.foodhub.com/v1/"; // Placeholder base URL
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));
  }

  @override
  Future delete(String path, {Object? data, Map<String, dynamic>? queryParameters}) async {
    final response = await dio.delete(path, data: data, queryParameters: queryParameters);
    return response.data;
  }

  @override
  Future get(String path, {Object? data, Map<String, dynamic>? queryParameters}) async {
    final response = await dio.get(path, data: data, queryParameters: queryParameters);
    return response.data;
  }

  @override
  Future patch(String path, {Object? data, Map<String, dynamic>? queryParameters, bool isFormData = false}) async {
    final response = await dio.patch(
      path,
      data: isFormData ? FormData.fromMap(data as Map<String, dynamic>) : data,
      queryParameters: queryParameters,
    );
    return response.data;
  }

  @override
  Future post(String path, {Object? data, Map<String, dynamic>? queryParameters, bool isFormData = false}) async {
    final response = await dio.post(
      path,
      data: isFormData ? FormData.fromMap(data as Map<String, dynamic>) : data,
      queryParameters: queryParameters,
    );
    return response.data;
  }

  @override
  Future put(String path, {Object? data, Map<String, dynamic>? queryParameters, bool isFormData = false}) async {
    final response = await dio.put(
      path,
      data: isFormData ? FormData.fromMap(data as Map<String, dynamic>) : data,
      queryParameters: queryParameters,
    );
    return response.data;
  }
}
