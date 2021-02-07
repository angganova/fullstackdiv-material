import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fullstackdiv_material/system/config/env_types.dart';
import 'package:fullstackdiv_material/system/config/environments.dart';
import 'package:injectable/injectable.dart';
import 'package:retry/retry.dart';
import 'package:fullstackdiv_material/rest/response_model/global_response.dart';
import 'package:fullstackdiv_material/system/debugger/logger_builder.dart';
import 'package:fullstackdiv_material/system/exception/api_global_exception.dart';
import 'package:fullstackdiv_material/system/exception/api_acceptable_exception.dart';
import 'package:fullstackdiv_material/system/global_extensions.dart';

@lazySingleton
class DefaultApiClient {
  DefaultApiClient(this._environments) {
    initClient();
  }

  final Environments _environments;
  final LoggerBuilder _loggerBuilder = LoggerBuilder('DefaultApiClient');
  final Dio _dio = Dio();

  /// Default timeouts, didn't want to risk for people who have low internet
  /// connection
  final Duration _defaultConnectTimeout = const Duration(seconds: 20);
  final Duration _defaultReceiveTimeout = const Duration(seconds: 15);
  final Duration _defaultSendTimeout = const Duration(seconds: 5);

  final String _defaultContentType = 'application/json; charset=utf-8';

  void initClient() {
    final BaseOptions options = BaseOptions(
      baseUrl: _environments.getBaseUrl,
      followRedirects: false,
      contentType: _defaultContentType,
      validateStatus: (int status) => status.isLessThan(500),
      headers: <String, dynamic>{
        HttpHeaders.authorizationHeader: _createBasicAuth
      },
      connectTimeout: _defaultConnectTimeout.inMilliseconds,
      receiveTimeout: _defaultReceiveTimeout.inMilliseconds,
      sendTimeout: _defaultSendTimeout.inMilliseconds,
    );
    _dio.options = options;

    if (_environments.getCurrentEnv == EnvTypes.dev) {
      _dio.interceptors
          .add(LogInterceptor(responseBody: true, requestBody: true));
    }
  }

  String _createBasicAuth() =>
      'Basic ${base64Encode(utf8.encode('${_environments.getBaseUn}'
          ':${_environments.getBasePw}'))}';

  Options _getAdditionalOptions(
          {Map<String, dynamic> extraHeaders,
          Duration sendTimeout,
          Duration receiveTimeout}) =>
      Options(
          headers: extraHeaders,
          sendTimeout:
              sendTimeout?.inMilliseconds ?? _defaultSendTimeout.inMilliseconds,
          receiveTimeout: receiveTimeout?.inMilliseconds ??
              _defaultReceiveTimeout.inMilliseconds);

  RetryOptions _getRetryOption({int maxRetries}) => RetryOptions(
        maxAttempts: maxRetries ?? 3,
      );

  /// GET - This is for api that return object as reply
  Future<Map<String, dynamic>> get(String url,
      {Map<String, dynamic> queryParams,
      Duration receiveTimeout,
      Duration sendTimeout,
      int maxRetries = 3,
      bool acceptError}) async {
    final RetryOptions _retryOption = _getRetryOption(
      maxRetries: maxRetries,
    );

    final Options _mergedOption = _getAdditionalOptions(
        receiveTimeout: receiveTimeout, sendTimeout: sendTimeout);

    return _retryOption.retry(
        () => basicGet(
              url: url,
              queryParams: queryParams,
              options: _mergedOption,
            ).then((Response<String> value) {
              if (isSuccessResponse(value)) {
                return jsonDecode(value.data) as Map<String, dynamic>;
              } else {
                throwApiException(value, acceptError: acceptError);
                return null;
              }
            }),
        retryIf: (Exception e) => shouldRetry(e),
        onRetry: (Exception e) => printError(url, e));
  }

  /// GET - This is for api that return array object as reply
  Future<List<dynamic>> getList(String url,
      {Map<String, dynamic> queryParams,
      Duration receiveTimeout,
      Duration sendTimeout,
      int maxRetries = 3,
      bool acceptError}) async {
    final RetryOptions _retryOption = _getRetryOption(
      maxRetries: maxRetries,
    );

    final Options _mergedOption = _getAdditionalOptions(
        receiveTimeout: receiveTimeout, sendTimeout: sendTimeout);

    return _retryOption.retry(
        () => basicGet(
              url: url,
              queryParams: queryParams,
              options: _mergedOption,
            ).then((Response<String> value) {
              if (isSuccessResponse(value)) {
                return jsonDecode(value.data) as List<dynamic>;
              } else {
                throwApiException(value, acceptError: acceptError);
                return null;
              }
            }),
        retryIf: (Exception e) => shouldRetry(e),
        onRetry: (Exception e) => printError(url, e));
  }

  /// POST - This is for api that return object as reply
  Future<Map<String, dynamic>> post(String url,
      {Map<String, dynamic> headers,
      Map<String, dynamic> queryParams,
      Map<String, dynamic> requestBody,
      Duration receiveTimeout,
      Duration sendTimeout,
      int maxRetries = 0,
      bool acceptError}) async {
    final RetryOptions _retryOption = _getRetryOption(
      maxRetries: maxRetries,
    );

    final Options _mergedOption = _getAdditionalOptions(
        receiveTimeout: receiveTimeout, sendTimeout: sendTimeout);

    return _retryOption.retry(
        () => basicPostWithBody(
              url: url,
              queryParams: queryParams,
              requestBody: requestBody,
              options: _mergedOption,
            ).then((Response<String> value) {
              if (isSuccessResponse(value)) {
                final Map<String, dynamic> data =
                    jsonDecode(value.data) as Map<String, dynamic>;
                return data;
              } else {
                throwApiException(value, acceptError: acceptError);
                return null;
              }
            }),
        retryIf: (Exception e) => shouldRetry(e),
        onRetry: (Exception e) => printError(url, e));
  }

  /// POST - This is for api that return object as reply
  Future<T> postFormData<T>(String url,
      {Map<String, dynamic> queryParams,
      FormData formData,
      Duration receiveTimeout,
      Duration sendTimeout,
      int maxRetries = 0,
      bool acceptError}) async {
    final RetryOptions _retryOption = _getRetryOption(
      maxRetries: maxRetries,
    );

    final Options _mergedOption = _getAdditionalOptions(
        receiveTimeout: receiveTimeout, sendTimeout: sendTimeout);

    return _retryOption.retry(
        () => basicPostWithFormData(
              url: url,
              queryParams: queryParams,
              formData: formData,
              options: _mergedOption,
            ).then((Response<String> value) {
              if (isSuccessResponse(value)) {
                return jsonDecode(value.data) as T;
              } else {
                throwApiException(value, acceptError: acceptError);
                return null;
              }
            }),
        retryIf: (Exception e) => shouldRetry(e),
        onRetry: (Exception e) => printError(url, e));
  }

  /// POST - This is for api that return array object as reply
  Future<List<dynamic>> postToList(String url,
      {Map<String, dynamic> queryParams,
      Map<String, dynamic> requestBody,
      Duration receiveTimeout,
      Duration sendTimeout,
      int maxRetries = 0,
      bool acceptError}) async {
    final RetryOptions _retryOption = _getRetryOption(
      maxRetries: maxRetries,
    );

    final Options _mergedOption = _getAdditionalOptions(
        receiveTimeout: receiveTimeout, sendTimeout: sendTimeout);

    return _retryOption.retry(
        () => basicPostWithBody(
              url: url,
              queryParams: queryParams,
              requestBody: requestBody,
              options: _mergedOption,
            ).then((Response<String> value) {
              if (isSuccessResponse(value)) {
                return jsonDecode(value.data) as List<dynamic>;
              } else {
                throwApiException(value, acceptError: acceptError);
                return null;
              }
            }),
        retryIf: (Exception e) => shouldRetry(e),
        onRetry: (Exception e) => printError(url, e));
  }

  /// PATCH - This is for api that return object as reply
  Future<Map<String, dynamic>> patch(String url,
      {Map<String, dynamic> queryParams,
      Map<String, dynamic> requestBody,
      Duration receiveTimeout,
      Duration sendTimeout,
      int maxRetries = 0,
      bool acceptError}) async {
    final RetryOptions _retryOption = _getRetryOption(
      maxRetries: maxRetries,
    );

    final Options _mergedOption = _getAdditionalOptions(
        receiveTimeout: receiveTimeout, sendTimeout: sendTimeout);

    return _retryOption.retry(
        () => basicPatch(
              url: url,
              queryParams: queryParams,
              requestBody: requestBody,
              options: _mergedOption,
            ).then((Response<String> value) {
              if (isSuccessResponse(value)) {
                return jsonDecode(value.data) as Map<String, dynamic>;
              } else {
                throwApiException(value, acceptError: acceptError);
                return null;
              }
            }),
        retryIf: (Exception e) => shouldRetry(e),
        onRetry: (Exception e) => printError(url, e));
  }

  /// PATCH - This is for api that return array object as reply
  Future<List<dynamic>> patchToList(String url,
      {Map<String, dynamic> queryParams,
      Map<String, dynamic> requestBody,
      Duration receiveTimeout,
      Duration sendTimeout,
      int maxRetries = 0,
      bool acceptError}) async {
    final RetryOptions _retryOption = _getRetryOption(
      maxRetries: maxRetries,
    );

    final Options _mergedOption = _getAdditionalOptions(
        receiveTimeout: receiveTimeout, sendTimeout: sendTimeout);

    return _retryOption.retry(
        () => basicPatch(
              url: url,
              queryParams: queryParams,
              requestBody: requestBody,
              options: _mergedOption,
            ).then((Response<String> value) {
              if (isSuccessResponse(value)) {
                return jsonDecode(value.data) as List<dynamic>;
              } else {
                throwApiException(value, acceptError: acceptError);
                return null;
              }
            }),
        retryIf: (Exception e) => shouldRetry(e),
        onRetry: (Exception e) => printError(url, e));
  }

  /// DELETE - This is for api that return object as reply
  Future<Map<String, dynamic>> delete(String url,
      {Map<String, dynamic> queryParams,
      Map<String, dynamic> requestBody,
      Duration receiveTimeout,
      Duration sendTimeout,
      int maxRetries = 0,
      bool acceptError}) async {
    final RetryOptions _retryOption = _getRetryOption(
      maxRetries: maxRetries,
    );

    final Options _mergedOption = _getAdditionalOptions(
        receiveTimeout: receiveTimeout, sendTimeout: sendTimeout);
    return _retryOption.retry(
        () => basicDelete(
              url: url,
              queryParams: queryParams,
              requestBody: requestBody,
              options: _mergedOption,
            ).then((Response<String> value) {
              if (isSuccessResponse(value)) {
                return jsonDecode(value.data) as Map<String, dynamic>;
              } else {
                throwApiException(value, acceptError: acceptError);
                return null;
              }
            }),
        retryIf: (Exception e) => shouldRetry(e),
        onRetry: (Exception e) => printError(url, e));
  }

  /// DELETE - This is for api that return array object as reply
  Future<List<dynamic>> deleteToList(String url,
      {Map<String, dynamic> queryParams,
      Map<String, dynamic> requestBody,
      Duration receiveTimeout,
      Duration sendTimeout,
      int maxRetries = 0,
      bool acceptError}) async {
    final RetryOptions _retryOption = _getRetryOption(
      maxRetries: maxRetries,
    );

    final Options _mergedOption = _getAdditionalOptions(
        receiveTimeout: receiveTimeout, sendTimeout: sendTimeout);

    return _retryOption.retry(
        () => basicDelete(
              url: url,
              queryParams: queryParams,
              requestBody: requestBody,
              options: _mergedOption,
            ).then((Response<String> value) {
              if (isSuccessResponse(value)) {
                return jsonDecode(value.data) as List<dynamic>;
              } else {
                throwApiException(value, acceptError: acceptError);
                return null;
              }
            }),
        retryIf: (Exception e) => shouldRetry(e),
        onRetry: (Exception e) => printError(url, e));
  }

  /// Basic api call start
  /// GET
  Future<Response<String>> basicGet({
    String url,
    Options options,
    Map<String, dynamic> queryParams,
  }) async {
    return await _dio.post<String>(
      url,
      queryParameters: queryParams,
      options: options ?? _getAdditionalOptions(),
    );
  }

  /// POST with body
  Future<Response<String>> basicPostWithBody({
    String url,
    Options options,
    Map<String, dynamic> queryParams,
    Map<String, dynamic> requestBody,
  }) async {
    return await _dio.post<String>(
      url,
      queryParameters: queryParams,
      data: requestBody,
      options: options ?? _getAdditionalOptions(),
    );
  }

  /// POST with form data
  Future<Response<String>> basicPostWithFormData({
    String url,
    Options options,
    FormData formData,
    Map<String, dynamic> queryParams,
  }) async {
    return await _dio.post<String>(
      url,
      queryParameters: queryParams,
      data: formData,
      options: options ?? _getAdditionalOptions(),
    );
  }

  /// PATCH
  Future<Response<String>> basicPatch({
    String url,
    Options options,
    Map<String, dynamic> queryParams,
    Map<String, dynamic> requestBody,
  }) async {
    return await _dio.patch<String>(
      url,
      queryParameters: queryParams,
      data: requestBody,
      options: options ?? _getAdditionalOptions(),
    );
  }

  /// DELETE
  Future<Response<String>> basicDelete({
    String url,
    Options options,
    Map<String, dynamic> queryParams,
    Map<String, dynamic> requestBody,
  }) async {
    return await _dio.delete<String>(
      url,
      queryParameters: queryParams,
      data: requestBody,
      options: options ?? _getAdditionalOptions(),
    );
  }

  /// Basic api call end

  /// Check the response is success and acceptable or not
  bool isSuccessResponse(Response<String> value) {
    if (value == null || value.statusCode.isNull) {
      return false;
    } else {
      return value.statusCode.isMoreOrEqualTo(200) &&
          value.statusCode.isLessThan(300);
    }
  }

  bool isAcceptableError(Response<String> value) {
    if (value == null || value.statusCode.isNull) {
      return false;
    } else {
      return value.statusCode.isMoreOrEqualTo(400) &&
          value.statusCode.isLessThan(500);
    }
  }

  /// Check the exception to determine whether the api should retry automatically
  bool shouldRetry(Exception e) {
    if (e is DioError) {
      return e.type == DioErrorType.SEND_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT ||
          e.type == DioErrorType.CONNECT_TIMEOUT;
    } else {
      return false;
    }
  }

  void throwApiException(Response<String> value, {bool acceptError = false}) {
    if (acceptError && isAcceptableError(value)) {
      /// Acceptable Error
      throwAcceptableApiError(value);
    } else {
      /// Unknown Error
      throwGlobalApiError(value);
    }
  }

  /// Throw acceptable error with GlobalResponse object
  void throwAcceptableApiError(Response<String> value) {
    try {
      throw ApiAcceptableException(value.data);
    } catch (e) {
      throw Exception('Unknown error happen, please try again');
    }
  }

  /// Throw global error with GlobalResponse object
  void throwGlobalApiError(Response<String> value) {
    try {
      final Map<String, dynamic> data =
          jsonDecode(value.data) as Map<String, dynamic>;
      final GlobalResponse _obj = GlobalResponse.fromJson(data);
      throw ApiGlobalException(ApiErrorType.General, _obj);
    } catch (e) {
      throw Exception('Unknown error happen, please try again');
    }
  }

  void printError(String endpoint, Exception exception) {
    printDebug(
        'API call error when calling ${_environments.getBaseUrl + endpoint}');
    printDebug('API call error because of ${dioErrorDescription(exception)}');
  }

  /// Logger print
  void printDebug(String print) => _loggerBuilder.printDebug(print);

  /// API error description
  String dioErrorDescription(Exception exception) {
    String errorDescription = '';
    if (exception is DioError) {
      switch (exception.type) {
        case DioErrorType.CANCEL:
          errorDescription = 'Request to API server was cancelled';
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = 'Send timeout with API server';
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = 'Connection timeout with API server';
          break;
        case DioErrorType.DEFAULT:
          errorDescription =
              'Connection to API server failed due to internet connection';
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = 'Receive timeout in connection with API server';
          break;
        case DioErrorType.RESPONSE:
          errorDescription =
              'Received invalid status code: ${exception.toString()}';
          break;
      }
    } else {
      errorDescription = 'Unexpected error occured';
    }
    return errorDescription;
  }
}
