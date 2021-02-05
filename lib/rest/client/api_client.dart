import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fullstackdiv_material/rest/response_model/global_response.dart';
import 'package:fullstackdiv_material/system/debugger/logger_builder.dart';
import 'package:fullstackdiv_material/system/exception/api_error_exception.dart';
import 'package:fullstackdiv_material/system/exception/global_exception.dart';
import 'package:fullstackdiv_material/system/global_variables.dart';
import 'package:retry/retry.dart';

class ApiClient {
  /// Switch between beta and production
  static bool betaMode = GlobalStrings.betaMode;

  static final _baseURL = betaMode
      ? GlobalStrings.restBaseUrlBeta
      : GlobalStrings.restBaseUrlProduction;

  static final _endpoint = GlobalStrings.restBaseUrlEndpoint;
  static final _userName = GlobalStrings.restHeaderUn;
  static final _password = GlobalStrings.restHeaderPw;
  static final _basicAuth = GlobalStrings.restHeaderName +
      base64Encode(utf8.encode('$_userName:$_password'));

  final baseUrlEnd = _baseURL + _endpoint;
  final imgUrl = _baseURL;
  final htmlFile = _baseURL + GlobalStrings.restHtmlFileEndpoint;
  final LoggerBuilder _loggerBuilder = LoggerBuilder('Dio');
  final Dio _dio = Dio();

  /// Default timeouts, didn't want to risk for people who have low internet
  /// connection
  final Duration _defaultConnectTimeout = const Duration(seconds: 20);
  final Duration _defaultReceiveTimeout = const Duration(seconds: 15);
  final Duration _defaultSendTimeout = const Duration(seconds: 5);

  ApiClient getInstance() {
    BaseOptions options = new BaseOptions(
      baseUrl: baseUrlEnd,
      followRedirects: false,
      contentType: 'application/json; charset=utf-8',
      validateStatus: (int status) => status < 500,
      headers: {HttpHeaders.authorizationHeader: _basicAuth},
      connectTimeout: _defaultConnectTimeout.inMilliseconds,
      receiveTimeout: _defaultReceiveTimeout.inMilliseconds,
      sendTimeout: _defaultSendTimeout.inMilliseconds,
    );
    _dio.options = options;

    if (betaMode)
      _dio.interceptors
          .add(LogInterceptor(responseBody: true, requestBody: true));

    return this;
  }

  Options getMergedOptions(
      {Map<String, dynamic> extraHeaders,
      Duration sendTimeout,
      Duration receiveTimeout}) {
    final Duration currentSendTimeout = _defaultSendTimeout;
    final Duration currentReceiveTimeout = _defaultReceiveTimeout;
    Map<String, dynamic> headers;
    if (extraHeaders != null && extraHeaders.isNotEmpty) {
      headers.addAll(extraHeaders);
    }

    return Options(
        sendTimeout:
            sendTimeout?.inMilliseconds ?? currentSendTimeout.inMilliseconds,
        receiveTimeout: receiveTimeout?.inMilliseconds ??
            currentReceiveTimeout.inMilliseconds,
        headers: headers);
  }

  ///
  /// GLOBAL RESPONSE CALL
  ///
  Future<GlobalResponse> globalPostCall(
      String endpoint, Map<String, dynamic> dataQuery) async {
    try {
      Response response =
          await _dio.post(baseUrlEnd + endpoint, data: dataQuery);
      return GlobalResponse.fromJson(response.data);
    } catch (error) {
      _loggerBuilder.printDebug('$endpoint, $error');
      return error;
    }
  }

  /// Minimum requirement for get API
  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, dynamic> queryParams,
    Duration receiveTimeout,
    Duration sendTimeout,
    int maxRetries = 3,
    Duration maxDelays,
  }) async {
    final RetryOptions retryOptions = RetryOptions(
      maxAttempts: maxRetries,
    );

    return retryOptions.retry(
      () => _dio
          .get<String>(
        url,
        queryParameters: queryParams,
        options: getMergedOptions(
            receiveTimeout: receiveTimeout, sendTimeout: sendTimeout),
      )
          .then((Response<String> value) {
        if (value.statusCode >= 200 && value.statusCode < 300) {
          return jsonDecode(value.data) as Map<String, dynamic>;
        } else {
          final Map<String, dynamic> data =
              jsonDecode(value.data) as Map<String, dynamic>;
          final GlobalResponse obj = GlobalResponse.fromJson(data);
          throw ApiErrorException(ApiErrorType.General, obj.message);
        }
      }),
      retryIf: (Exception e) =>
          e is DioError &&
          (e.type == DioErrorType.SEND_TIMEOUT ||
              e.type == DioErrorType.RECEIVE_TIMEOUT ||
              e.type == DioErrorType.CONNECT_TIMEOUT),
    );
  }

  // This is for api that read array object as reply
  Future<List<dynamic>> getList(
    String url, {
    Map<String, dynamic> queryParams,
    Duration receiveTimeout,
    Duration sendTimeout,
    int maxRetries = 3,
    Duration maxDelays,
  }) async {
    final RetryOptions retryOptions = RetryOptions(
      maxAttempts: maxRetries,
    );
    return retryOptions.retry(
      () => _dio
          .get<String>(
        url,
        queryParameters: queryParams,
        options: getMergedOptions(),
      )
          .then((Response<String> value) {
        if (value.statusCode >= 200 && value.statusCode < 300) {
          return jsonDecode(value.data) as List<dynamic>;
        } else {
          final Map<String, dynamic> data =
              jsonDecode(value.data) as Map<String, dynamic>;
          final GlobalResponse obj = GlobalResponse.fromJson(data);
          throw ApiErrorException(ApiErrorType.General, obj.message);
        }
      }),
      retryIf: (Exception e) =>
          e is DioError &&
          (e.type == DioErrorType.SEND_TIMEOUT ||
              e.type == DioErrorType.RECEIVE_TIMEOUT ||
              e.type == DioErrorType.CONNECT_TIMEOUT),
    );
  }

  /// Minimum requirement for post API
  Future<Map<String, dynamic>> post(
    String url, {
    Map<String, dynamic> queryParams,
    Map<String, dynamic> requestBody,
    Duration receiveTimeout,
    Duration sendTimeout,
    int maxRetries = 3,
    Duration maxDelays,
    Map<String, dynamic> headers,
  }) async {
    final RetryOptions retryOptions = RetryOptions(
      maxAttempts: maxRetries,
    );
    final Options mergedOptions = getMergedOptions(extraHeaders: headers);
    return retryOptions.retry(
      () => _dio
          .post<String>(
        url,
        queryParameters: queryParams,
        data: requestBody,
        options: mergedOptions,
      )
          .then((Response<String> value) {
        final Map<String, dynamic> data =
            jsonDecode(value.data) as Map<String, dynamic>;
        if (value.statusCode >= 200 && value.statusCode < 300) {
          final Map<String, dynamic> data =
              jsonDecode(value.data) as Map<String, dynamic>;
          return data;
        } else {
          final GlobalResponse obj = GlobalResponse.fromJson(data);
          throw ApiErrorException(ApiErrorType.General, obj.message);
        }
      }),
      retryIf: (Exception e) =>
          e is DioError &&
          (e.type == DioErrorType.SEND_TIMEOUT ||
              e.type == DioErrorType.RECEIVE_TIMEOUT ||
              e.type == DioErrorType.CONNECT_TIMEOUT),
    );
  }

  /// Minimum requirement for posting FormData API
  Future<T> postFormData<T>(
    String url, {
    Map<String, dynamic> queryParams,
    FormData formData,
    Duration receiveTimeout,
    Duration sendTimeout,
    int maxRetries = 3,
    Duration maxDelays,
  }) async {
    final RetryOptions retryOptions = RetryOptions(
      maxAttempts: maxRetries,
    );

    return retryOptions.retry(
      () => _dio
          .post<String>(
        url,
        queryParameters: queryParams,
        data: formData,
        options: getMergedOptions(),
      )
          .then((Response<String> value) {
        if (value.statusCode >= 200 && value.statusCode < 300) {
          return jsonDecode(value.data) as T;
        } else {
          final Map<String, dynamic> data =
              jsonDecode(value.data) as Map<String, dynamic>;
          final GlobalResponse obj = GlobalResponse.fromJson(data);
          throw ApiErrorException(ApiErrorType.General, obj.message);
        }
      }),
      retryIf: (Exception e) =>
          e is DioError &&
          (e.type == DioErrorType.SEND_TIMEOUT ||
              e.type == DioErrorType.RECEIVE_TIMEOUT ||
              e.type == DioErrorType.CONNECT_TIMEOUT),
    );
  }

  /// Minimum requirement for patch API
  Future<Map<String, dynamic>> patch(
    String url, {
    Map<String, dynamic> queryParams,
    Map<String, dynamic> requestBody,
    Duration receiveTimeout,
    Duration sendTimeout,
    int maxRetries = 0,
    Duration maxDelays,
  }) async {
    final RetryOptions retryOptions = RetryOptions(
      maxAttempts: maxRetries,
    );
    return retryOptions.retry(
      () => _dio
          .patch<String>(
        url,
        queryParameters: queryParams,
        data: requestBody,
        options: getMergedOptions(),
      )
          .then((Response<String> value) {
        if (value.statusCode >= 200 && value.statusCode < 300) {
          return jsonDecode(value.data) as Map<String, dynamic>;
        } else {
          final Map<String, dynamic> data =
              jsonDecode(value.data) as Map<String, dynamic>;
          final GlobalResponse obj = GlobalResponse.fromJson(data);
          throw ApiErrorException(ApiErrorType.General, obj.message);
        }
      }),
      retryIf: (Exception e) =>
          e is DioError &&
          (e.type == DioErrorType.SEND_TIMEOUT ||
              e.type == DioErrorType.RECEIVE_TIMEOUT ||
              e.type == DioErrorType.CONNECT_TIMEOUT),
    );
  }

  /// Use this function to patch and return direct list of json object
  Future<List<Map<String, dynamic>>> patchToList(
    String url, {
    Map<String, dynamic> queryParams,
    Map<String, dynamic> requestBody,
    Duration receiveTimeout,
    Duration sendTimeout,
    int maxRetries = 0,
    Duration maxDelays,
  }) async {
    final RetryOptions retryOptions = RetryOptions(
      maxAttempts: maxRetries,
    );
    return retryOptions.retry(
      () => _dio
          .patch<String>(
        url,
        queryParameters: queryParams,
        data: requestBody,
        options: getMergedOptions(),
      )
          .then((Response<String> value) {
        if (value.statusCode >= 200 && value.statusCode < 300) {
          final String toMapString = '\{\"data\":${value.data}\}';
          final Map<String, dynamic> resultMap =
              jsonDecode(toMapString) as Map<String, dynamic>;
          final List<Map<String, dynamic>> result = (resultMap['data']
                  as List<dynamic>)
              ?.map((dynamic e) => e == null ? null : e as Map<String, dynamic>)
              ?.toList();

          return result;
        } else {
          final Map<String, dynamic> data =
              jsonDecode(value.data) as Map<String, dynamic>;
          final GlobalResponse obj = GlobalResponse.fromJson(data);
          throw ApiErrorException(ApiErrorType.General, obj.message);
        }
      }),
      retryIf: (Exception e) =>
          e is DioError &&
          (e.type == DioErrorType.SEND_TIMEOUT ||
              e.type == DioErrorType.RECEIVE_TIMEOUT ||
              e.type == DioErrorType.CONNECT_TIMEOUT),
    );
  }

  /// Use this function to retrieve direct list of json object
  Future<List<Map<String, dynamic>>> postToList(
    String url, {
    Map<String, dynamic> queryParams,
    Map<String, dynamic> requestBody,
    Duration receiveTimeout,
    Duration sendTimeout,
    int maxRetries = 3,
    Duration maxDelays,
  }) async {
    final RetryOptions retryOptions = RetryOptions(
      maxAttempts: maxRetries,
    );
    return retryOptions.retry(
      () => _dio
          .post<String>(
        url,
        queryParameters: queryParams,
        data: requestBody,
        options: getMergedOptions(),
      )
          .then((Response<String> value) {
        if (value.statusCode >= 200 && value.statusCode < 300) {
          final String toMapString = '\{\"data\":${value.data}\}';
          final Map<String, dynamic> resultMap =
              jsonDecode(toMapString) as Map<String, dynamic>;
          final List<Map<String, dynamic>> result = (resultMap['data']
                  as List<dynamic>)
              ?.map((dynamic e) => e == null ? null : e as Map<String, dynamic>)
              ?.toList();

          return result;
        } else {
          final Map<String, dynamic> data =
              jsonDecode(value.data) as Map<String, dynamic>;
          final GlobalResponse obj = GlobalResponse.fromJson(data);
          throw ApiErrorException(ApiErrorType.General, obj.message);
        }
      }),
      retryIf: (Exception e) =>
          e is DioError &&
          (e.type == DioErrorType.SEND_TIMEOUT ||
              e.type == DioErrorType.RECEIVE_TIMEOUT ||
              e.type == DioErrorType.CONNECT_TIMEOUT),
    );
  }

  Future<Map<String, dynamic>> postAcceptError(
    String url, {
    Map<String, dynamic> queryParams,
    Map<String, dynamic> requestBody,
    Map<String, dynamic> headers,
    Duration receiveTimeout,
    Duration sendTimeout,
  }) async {
    final Options mergedOptions = getMergedOptions(
        extraHeaders: headers,
        sendTimeout: sendTimeout,
        receiveTimeout: receiveTimeout);

    return _dio
        .post<String>(
      url,
      queryParameters: queryParams,
      data: requestBody,
      options: mergedOptions,
    )
        .then((Response<String> value) {
      if (value.statusCode >= 200 && value.statusCode < 300) {
        /// Success
        return jsonDecode(value.data) as Map<String, dynamic>;
      } else if (value.statusCode >= 400 && value.statusCode < 500) {
        /// Client Error
        throw GlobalErrorException(value.data);
      } else if (value.statusCode >= 500) {
        /// Server Error
        final Map<String, dynamic> data =
            jsonDecode(value.data) as Map<String, dynamic>;
        final GlobalResponse obj = GlobalResponse.fromJson(data);
        throw Exception(obj.message);
      } else {
        final Map<String, dynamic> data =
            jsonDecode(value.data) as Map<String, dynamic>;
        final GlobalResponse obj = GlobalResponse.fromJson(data);
        throw Exception(obj.message);
      }
    });
  }

  /// Minimum requirement for post API
  Future<Map<String, dynamic>> delete(
    String url, {
    Map<String, dynamic> queryParams,
    Map<String, dynamic> requestBody,
    Duration receiveTimeout,
    Duration sendTimeout,
    int maxRetries = 3,
    Duration maxDelays,
  }) async {
    final RetryOptions retryOptions = RetryOptions(
      maxAttempts: maxRetries,
    );
    return retryOptions.retry(
      () => _dio
          .delete<String>(
        url,
        queryParameters: queryParams,
        data: requestBody,
        options: getMergedOptions(),
      )
          .then((Response<String> value) {
        if (value.statusCode >= 200 && value.statusCode < 300) {
          return jsonDecode(value.data) as Map<String, dynamic>;
        } else {
          final Map<String, dynamic> data =
              jsonDecode(value.data) as Map<String, dynamic>;
          final GlobalResponse obj = GlobalResponse.fromJson(data);
          throw ApiErrorException(ApiErrorType.General, obj.message);
        }
      }),
      retryIf: (Exception e) =>
          e is DioError &&
          (e.type == DioErrorType.SEND_TIMEOUT ||
              e.type == DioErrorType.RECEIVE_TIMEOUT ||
              e.type == DioErrorType.CONNECT_TIMEOUT),
    );
  }

  /// Use this function to retrieve direct list of json object
  Future<List<Map<String, dynamic>>> deleteToList(
    String url, {
    Map<String, dynamic> queryParams,
    Map<String, dynamic> requestBody,
    Duration receiveTimeout,
    Duration sendTimeout,
    int maxRetries = 3,
    Duration maxDelays,
  }) async {
    final RetryOptions retryOptions = RetryOptions(
      maxAttempts: maxRetries,
    );
    return retryOptions.retry(
      () => _dio
          .delete<String>(
        url,
        queryParameters: queryParams,
        data: requestBody,
        options: getMergedOptions(),
      )
          .then((Response<String> value) {
        if (value.statusCode >= 200 && value.statusCode < 300) {
          final String toMapString = '\{\"data\":${value.data}\}';
          final Map<String, dynamic> resultMap =
              jsonDecode(toMapString) as Map<String, dynamic>;
          final List<Map<String, dynamic>> result = (resultMap['data']
                  as List<dynamic>)
              ?.map((dynamic e) => e == null ? null : e as Map<String, dynamic>)
              ?.toList();

          return result;
        } else {
          final Map<String, dynamic> data =
              jsonDecode(value.data) as Map<String, dynamic>;
          final GlobalResponse obj = GlobalResponse.fromJson(data);
          throw ApiErrorException(ApiErrorType.General, obj.message);
        }
      }),
      retryIf: (Exception e) =>
          e is DioError &&
          (e.type == DioErrorType.SEND_TIMEOUT ||
              e.type == DioErrorType.RECEIVE_TIMEOUT ||
              e.type == DioErrorType.CONNECT_TIMEOUT),
    );
  }
}
