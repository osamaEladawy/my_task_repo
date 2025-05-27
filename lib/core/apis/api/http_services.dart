import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'api_services.dart';

class HttpServices extends ApiServices {
  final http.Client client;

  HttpServices({required this.client});

  @override
  delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isForm = false,
  }) async {
    try {
      final response = await client.delete(
        Uri.parse(path),
        body: data,
        headers: headers,
      );
      return response;
    } on SocketException catch (e) {
      throw Exception("No Internet: ${e.message}");
    } on TimeoutException catch (e) {
      throw Exception("Request timeout: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }

  @override
  get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await client.get(Uri.parse(path), headers: headers);
      return response;
    } on SocketException catch (e) {
      throw Exception("No Internet: ${e.message}");
    } on TimeoutException catch (e) {
      throw Exception("Request timeout: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }

  @override
  patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isForm = false,
  }) async {
    try {
      final response = await client.patch(
        Uri.parse(path),
        body: data,
        headers: headers,
      );
      return response;
    } on SocketException catch (e) {
      throw Exception("No Internet: ${e.message}");
    } on TimeoutException catch (e) {
      throw Exception("Request timeout: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }

  @override
  post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isForm = false,
  }) async {
    try {
      final response = await client.post(
        Uri.parse(path),
        body: data,
        headers: headers,
      );
      return response;
    } on SocketException catch (e) {
      throw Exception("No Internet: ${e.message}");
    } on TimeoutException catch (e) {
      throw Exception("Request timeout: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }

  @override
  Future put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isForm = false,
  }) async {
    try {
      final response = await client.put(
        Uri.parse(path),
        body: data,
        headers: headers,
      );
      return response;
    } on SocketException catch (e) {
      throw Exception("No Internet: ${e.message}");
    } on TimeoutException catch (e) {
      throw Exception("Request timeout: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }
}
