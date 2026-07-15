import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:siam_portfolio/core/models/response_data.dart';
import 'package:siam_portfolio/core/services/storage_service.dart';

/// Use this global object anywhere after importing this file:
///
/// final response = await networkCaller.get('https://example.com/api/products');
final networkCaller = NetworkCaller.instance;

class NetworkCaller {
  NetworkCaller._();

  static final NetworkCaller instance = NetworkCaller._();

  factory NetworkCaller() => instance;

  final http.Client _client = http.Client();
  final Logger _logger = Logger(
    filter: ProductionFilter(),
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: false,
      dateTimeFormat: DateTimeFormat.onlyTime,
    ),
  );

  Duration timeout = const Duration(seconds: 20);

  Future<ResponseData> get(
    String url, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    String? token,
    bool useToken = true,
  }) {
    return request(
      url,
      method: 'GET',
      query: query,
      headers: headers,
      token: token,
      useToken: useToken,
    );
  }

  Future<ResponseData> post(
    String url, {
    Object? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    String? token,
    bool useToken = true,
  }) {
    return request(
      url,
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
      token: token,
      useToken: useToken,
    );
  }

  Future<ResponseData> put(
    String url, {
    Object? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    String? token,
    bool useToken = true,
  }) {
    return request(
      url,
      method: 'PUT',
      body: body,
      query: query,
      headers: headers,
      token: token,
      useToken: useToken,
    );
  }

  Future<ResponseData> patch(
    String url, {
    Object? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    String? token,
    bool useToken = true,
  }) {
    return request(
      url,
      method: 'PATCH',
      body: body,
      query: query,
      headers: headers,
      token: token,
      useToken: useToken,
    );
  }

  Future<ResponseData> delete(
    String url, {
    Object? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    String? token,
    bool useToken = true,
  }) {
    return request(
      url,
      method: 'DELETE',
      body: body,
      query: query,
      headers: headers,
      token: token,
      useToken: useToken,
    );
  }

  Future<ResponseData> request(
    String url, {
    String method = 'GET',
    Object? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    String? token,
    bool useToken = true,
  }) async {
    final requestMethod = method.toUpperCase();
    final uri = _buildUri(url, query);

    try {
      final request = http.Request(requestMethod, uri)
        ..headers.addAll(
          _buildHeaders(
            token: token,
            useToken: useToken,
            extraHeaders: headers,
          ),
        );

      final encodedBody = _encodeBody(body);
      if (encodedBody != null) {
        request.body = encodedBody;
      }

      final streamedResponse = await _client.send(request).timeout(timeout);
      final response = await http.Response.fromStream(streamedResponse);

      _logResponse(requestMethod, uri, response);
      return _handleResponse(response);
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<ResponseData> upload(
    String url, {
    String method = 'POST',
    Map<String, String>? fields,
    Map<String, String>? files,
    Map<String, String>? headers,
    String? token,
    bool useToken = true,
  }) async {
    try {
      final request = http.MultipartRequest(method.toUpperCase(), Uri.parse(url))
        ..headers.addAll(
          _buildHeaders(
            token: token,
            useToken: useToken,
            extraHeaders: headers,
            hasJsonBody: false,
          ),
        );

      if (fields != null) {
        request.fields.addAll(fields);
      }

      if (files != null) {
        for (final file in files.entries) {
          request.files.add(
            await http.MultipartFile.fromPath(file.key, file.value),
          );
        }
      }

      final streamedResponse = await _client.send(request).timeout(timeout);
      final response = await http.Response.fromStream(streamedResponse);

      _logResponse(method.toUpperCase(), request.url, response);
      return _handleResponse(response);
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<ResponseData> getRequest(String url, {String? token}) {
    return get(url, token: token);
  }

  Future<ResponseData> postRequest(
    String url, {
    Map<String, dynamic>? body,
    String? token,
  }) {
    return post(url, body: body, token: token);
  }

  Future<ResponseData> putRequest(
    String url, {
    Map<String, dynamic>? body,
    String? token,
  }) {
    return put(url, body: body, token: token);
  }

  Future<ResponseData> patchRequest(
    String url, {
    Map<String, dynamic>? body,
    String? token,
  }) {
    return patch(url, body: body, token: token);
  }

  Future<ResponseData> deleteRequest(
    String url, {
    Map<String, dynamic>? body,
    String? token,
  }) {
    return delete(url, body: body, token: token);
  }

  Future<ResponseData> multipartRequest(
    String url, {
    required String method,
    Map<String, String>? fields,
    Map<String, String>? files,
    String? token,
  }) {
    return upload(
      url,
      method: method,
      fields: fields,
      files: files,
      token: token,
    );
  }

  Uri _buildUri(String url, Map<String, dynamic>? query) {
    final uri = Uri.parse(url);
    if (query == null || query.isEmpty) {
      return uri;
    }

    final queryParameters = Map<String, String>.from(uri.queryParameters);
    for (final item in query.entries) {
      final value = item.value;
      if (value != null) {
        queryParameters[item.key] = value.toString();
      }
    }

    return uri.replace(queryParameters: queryParameters);
  }

  Map<String, String> _buildHeaders({
    required String? token,
    required bool useToken,
    required Map<String, String>? extraHeaders,
    bool hasJsonBody = true,
  }) {
    final headers = <String, String>{
      'Accept': 'application/json',
      if (hasJsonBody) 'Content-Type': 'application/json',
    };

    final authToken = token ?? _readStoredToken(useToken);
    if (authToken != null && authToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $authToken';
    }

    if (extraHeaders != null) {
      headers.addAll(extraHeaders);
    }

    return headers;
  }

  String? _readStoredToken(bool useToken) {
    if (!useToken || !StorageService.isInitialized) {
      return null;
    }
    return StorageService.getUserToken();
  }

  String? _encodeBody(Object? body) {
    if (body == null) {
      return null;
    }
    if (body is String) {
      return body;
    }
    return jsonEncode(body);
  }

  ResponseData _handleResponse(http.Response response) {
    final decodedBody = _decodeResponseBody(response.body);
    final bodyMap = _asMap(decodedBody);
    final isSuccessStatus = response.statusCode >= 200 && response.statusCode < 300;
    final serverSuccess = bodyMap?['success'];
    final isSuccess = isSuccessStatus && serverSuccess != false;

    if (isSuccess) {
      return ResponseData(
        isSuccess: true,
        statusCode: response.statusCode,
        responseData: decodedBody,
        errorMessage: '',
      );
    }

    return ResponseData(
      isSuccess: false,
      statusCode: response.statusCode,
      responseData: decodedBody,
      errorMessage: _errorMessage(response.statusCode, bodyMap),
    );
  }

  dynamic _decodeResponseBody(String body) {
    if (body.trim().isEmpty) {
      return <String, dynamic>{};
    }

    try {
      return jsonDecode(body);
    } on FormatException {
      return body;
    }
  }

  Map<String, dynamic>? _asMap(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value;
    }
    if (value is Map) {
      return value.map((key, item) => MapEntry(key.toString(), item));
    }
    return null;
  }

  String _errorMessage(int statusCode, Map<String, dynamic>? body) {
    final message = _readMessage(body?['message']);
    if (message.isNotEmpty) {
      return message;
    }

    final errorSources = _readErrorList(body?['errorSources']);
    if (errorSources.isNotEmpty) {
      return errorSources;
    }

    final errors = _readErrorList(body?['errors']);
    if (errors.isNotEmpty) {
      return errors;
    }

    return switch (statusCode) {
      400 => 'Bad request. Please check your information.',
      401 => 'Unauthorized. Please login again.',
      403 => 'You do not have permission for this action.',
      404 => 'Data not found.',
      408 => 'Request timeout. Please try again.',
      422 => 'Validation failed. Please check your information.',
      >= 500 => 'Server error. Please try again later.',
      _ => 'Something went wrong. Please try again.',
    };
  }

  String _readMessage(dynamic value) {
    if (value == null) {
      return '';
    }
    if (value is List) {
      return value
          .where((item) => item != null)
          .map((item) => item.toString().trim())
          .where((item) => item.isNotEmpty)
          .join(', ');
    }
    return value.toString().trim();
  }

  String _readErrorList(dynamic value) {
    if (value is! List) {
      return '';
    }

    return value
        .map((item) {
          final itemMap = _asMap(item);
          return _readMessage(itemMap?['message'] ?? item);
        })
        .where((item) => item.isNotEmpty)
        .join(', ');
  }

  ResponseData _handleError(Object error) {
    _logger.e('Request error', error: error);

    if (error is TimeoutException) {
      return const ResponseData(
        isSuccess: false,
        statusCode: 408,
        responseData: '',
        errorMessage: 'Request timeout. Please try again.',
      );
    }

    if (error is SocketException || error is http.ClientException) {
      return const ResponseData(
        isSuccess: false,
        statusCode: 0,
        responseData: '',
        errorMessage: 'No internet connection. Please try again.',
      );
    }

    return const ResponseData(
      isSuccess: false,
      statusCode: 500,
      responseData: '',
      errorMessage: 'Unexpected error occurred. Please try again.',
    );
  }

  void _logResponse(String method, Uri uri, http.Response response) {
    _logger.i('$method $uri -> ${response.statusCode}');
    _logger.d(response.body);
  }
}
