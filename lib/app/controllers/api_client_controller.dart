import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'package:lms_app/app/routes/app_pages.dart';

/// Controller for managing API client with Dio HTTP client
/// Handles authentication, session management, and error handling
class ApiClientController extends GetxController {
  late Dio dio;
  final _storage = GetStorage();

  // Storage keys
  static const String _hostKey = 'host_url';
  static const String _cookieKey = 'cookies';

  @override
  void onInit() {
    super.onInit();
    _initializeDioClient();
    _setupInterceptors();
    _handleAutoLogin();
  }

  /// Initialize Dio client with base configuration
  void _initializeDioClient() {
    final savedHost = _storage.read<String>(_hostKey);
    final savedCookies = _storage.read<String>(_cookieKey);

    dio = Dio(
      BaseOptions(
        baseUrl: savedHost ?? '',
        validateStatus: (_) =>
            true, // Don't throw exceptions for HTTP error codes
        headers: {
          'X-Mobile-App': '1',
          if (savedCookies != null) 'Cookie': savedCookies,
        },
      ),
    );
  }

  /// Setup HTTP interceptors for logging and error handling
  void _setupInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onResponse: _onResponse,
        onError: _onError,
      ),
    );
  }

  /// Handle auto-login if session exists
  void _handleAutoLogin() {
    final savedHost = _storage.read<String>(_hostKey);
    final savedCookies = _storage.read<String>(_cookieKey);

    if (_hasValidSession(savedHost, savedCookies)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (Get.currentRoute != Routes.HOME) {
          Get.offAllNamed(Routes.HOME);
        }
      });
    }
  }

  /// Check if user has a valid session
  bool _hasValidSession(String? host, String? cookies) {
    return host != null &&
        host.isNotEmpty &&
        cookies != null &&
        cookies.isNotEmpty;
  }

  // ==================== INTERCEPTOR METHODS ====================

  /// Handle outgoing requests - log request details
  void _onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logRequest(options);
    handler.next(options);
  }

  /// Handle incoming responses - manage cookies, auth, and errors
  void _onResponse(Response response, ResponseInterceptorHandler handler) {
    // _handleCookieUpdates(response);
    _logResponse(response);
    _handleAuthenticationErrors(response);
    _handleHttpErrors(response);
    handler.next(response);
  }

  /// Handle request errors
  void _onError(DioException error, ErrorInterceptorHandler handler) {
    log('✗ $error', error: error, name: 'onError');
    handler.next(error);
  }

  // ==================== COOKIE MANAGEMENT ====================

  /// Extract and store cookies from response headers
  void _handleCookieUpdates(Response response) {
    final setCookies = response.headers.map['set-cookie'];
    if (setCookies != null && setCookies.isNotEmpty) {
      _updateCookies(setCookies);
    }
  }

  /// Update stored cookies and Dio headers
  void _updateCookies(List<String> setCookies) {
    final cookieString =
        setCookies.map((c) => c.split(';').first.trim()).join('; ');
    _storage.write(_cookieKey, cookieString);
    dio.options.headers['Cookie'] = cookieString;
  }

  // ==================== ERROR HANDLING ====================

  /// Handle 401 authentication errors
  void _handleAuthenticationErrors(Response response) {
    if (response.statusCode == 401) {
      logout();
      if (Get.currentRoute != Routes.LOGIN) {
        Get.offAllNamed(Routes.LOGIN);
      }
    }
  }

  /// Handle HTTP errors (4xx, 5xx)
  void _handleHttpErrors(Response response) {
    if (response.statusCode! >= 400) {
      try {
        _processErrorResponse(response);
      } catch (e) {
        log('Error handling response: $e', name: 'onResponseError');
      }
    }
  }

  /// Process different types of error responses
  void _processErrorResponse(Response response) {
    if (response.data is String) {
      _showErrorSnackbar('Error', response.data as String);
    } else if (response.data is Map<String, dynamic>) {
      _handleStructuredErrorResponse(response.data as Map<String, dynamic>);
    }
  }

  /// Handle structured error responses from server
  void _handleStructuredErrorResponse(Map<String, dynamic> data) {
    if (data.containsKey('_server_messages')) {
      _handleServerMessages(data['_server_messages']);
    } else if (data.containsKey('message')) {
      _handleSimpleMessage(data['message']);
    }
  }

  /// Handle server messages format (typically from Frappe)
  void _handleServerMessages(dynamic serverMessages) {
    if (serverMessages != null &&
        serverMessages is String &&
        serverMessages.isNotEmpty) {
      try {
        final serverMessage = jsonDecode(serverMessages)[0];
        final message = jsonDecode(serverMessage)['message'];
        final title = jsonDecode(serverMessage)['title'];
        _showHtmlErrorSnackbar(
          title ?? 'Error',
          message ?? 'Something went wrong',
        );
      } catch (e) {
        log('Error parsing server messages: $e', name: 'ServerMessageError');
      }
    }
  }

  /// Handle simple message format
  void _handleSimpleMessage(dynamic message) {
    if (message != null && message is String && message.isNotEmpty) {
      _showErrorSnackbar('Error', message);
    }
  }

  /// Show basic error snackbar
  void _showErrorSnackbar(String title, String message) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        title,
        message,
        backgroundColor: Theme.of(Get.context!).colorScheme.primary,
        colorText: Colors.white,
      );
    }
  }

  /// Show HTML-formatted error snackbar
  void _showHtmlErrorSnackbar(String title, String message) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        title,
        message,
        messageText: HtmlWidget(
          message,
          textStyle: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(Get.context!).colorScheme.primary,
        colorText: Colors.white,
      );
    }
  }

  // ==================== LOGGING ====================

  /// Log outgoing request details
  void _logRequest(RequestOptions options) {
    log(
      '→ ${options.method} ${options.baseUrl}${options.path}\n'
      '  Query: ${options.queryParameters}\n'
      '  Request: ${options.data}\n',
      name: 'onRequest',
    );
  }

  /// Log incoming response details
  void _logResponse(Response response) {
    log(
      '← ${response.statusCode} ${response.requestOptions.path}\n'
      '  Query: ${response.requestOptions.queryParameters}\n'
      '  Request: ${response.requestOptions.data}\n'
      '  Response: ${response.toString()}',
      name: 'onResponse',
    );
  }

  // ==================== FRAPPE API METHODS ====================

  /// Get list of documents from Frappe server
  Future<Response<dynamic>> getList(
    String doctype, {
    dynamic filters, // Can be Map<String, dynamic> or List<List<dynamic>>
    List<List<dynamic>>? orFilters,
    List<String>? fields = const ['*'],
    int? limit,
    String? orderBy,
  }) async {
    try {
      final data = _buildListRequestData(
        doctype: doctype,
        filters: filters,
        orFilters: orFilters,
        fields: fields,
        limit: limit,
        orderBy: orderBy,
      );

      return await dio.post('/api/method/frappe.client.get_list', data: data);
    } on DioException catch (e) {
      log('✗ getList error: ${e.message}', error: e, name: 'FrappeAPI');
      rethrow;
    }
  }

  /// Insert a document
  Future<Response<dynamic>> insertDoc({
    required Map<String, dynamic> doc,
  }) async {
    try {
      return await dio.post(
        '/api/method/frappe.client.insert',
        data: {'doc': doc},
      );
    } on DioException catch (e) {
      log('✗ insertDoc error: ${e.message}', error: e, name: 'FrappeAPI');
      rethrow;
    }
  }

  /// Get a list of documents with filters
  Future<Response<dynamic>> getListWithFilters(
    String doctype, {
    dynamic filters, // Can be Map<String, dynamic> or List<List<dynamic>>
    dynamic orFilters,
    List<String>? fields = const ['*'],
    int? limit,
    String? orderBy,
    String? groupBy,
    int? start,
  }) async {
    try {
      final data = _buildListRequestData(
        doctype: doctype,
        filters: filters,
        orFilters: orFilters,
        fields: fields,
        limit: limit,
        orderBy: orderBy,
        groupBy: groupBy,
        start: start,
      );

      return await dio.post(
        '/api/method/bizkit_hrms.api.common.get_doc_with_filters',
        data: data,
      );
    } on DioException catch (e) {
      log('✗ getList error: ${e.message}', error: e, name: 'FrappeAPI');
      rethrow;
    }
  }

  /// Get single document from Frappe server
  Future<Response<dynamic>> getDoc(
    String doctype, {
    required String name,
  }) async {
    try {
      final data = {'doctype': doctype, 'name': name};
      return await dio.post('/api/method/frappe.client.get', data: data);
    } on DioException catch (e) {
      log('✗ getDoc error: ${e.message}', error: e, name: 'FrappeAPI');
      rethrow;
    }
  }

  /// Build request data for getList method
  Map<String, dynamic> _buildListRequestData({
    required String doctype,
    dynamic filters,
    dynamic orFilters,
    List<String>? fields,
    int? limit,
    String? orderBy,
    String? groupBy,
    int? start,
  }) {
    final data = <String, dynamic>{'doctype': doctype, 'fields': fields};

    if (filters != null) data['filters'] = filters;
    if (orFilters != null) data['or_filters'] = orFilters;
    if (limit != null) data['limit_page_length'] = limit;
    if (orderBy != null) data['order_by'] = orderBy;
    if (groupBy != null) data['group_by'] = groupBy;
    if (start != null) data['start'] = start;
    return data;
  }

  // ==================== GENERIC HTTP METHODS ====================

  /// Perform GET request
  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      log('✗ GET error: ${e.message}', error: e, name: 'HTTP');
      rethrow;
    }
  }

  /// Perform PUT request
  Future<Response<dynamic>> put(String path, {dynamic data}) async {
    try {
      return await dio.put(path, data: data);
    } on DioException catch (e) {
      log('✗ PUT error: ${e.message}', error: e, name: 'HTTP');
      rethrow;
    }
  }

  /// Perform POST request
  Future<Response<dynamic>> post(String path, {dynamic data}) async {
    try {
      return await dio.post(path, data: data);
    } on DioException catch (e) {
      log('✗ POST error: ${e.message}', error: e, name: 'HTTP');
      rethrow;
    }
  }

  // ==================== GETTERS ====================

  /// Get current host URL
  String? get hostUrl =>
      dio.options.baseUrl.isEmpty ? null : dio.options.baseUrl;

  /// Get current cookies
  String? get cookies => dio.options.headers['Cookie'];

  // ==================== AUTHENTICATION ====================

  /// Authenticate user with username and password
  Future<bool> loginWithEmailPassword(
      String hostUrl, String username, String password) async {
    await _setHostUrl(hostUrl);
    try {
      final response = await dio.post(
        "/api/method/lms_360ithub.utils.custom_login.login_with_email_password",
        data: {'email': username, 'password': password},
      );

      final success = _isLoginSuccessful(response);
      if (success) {
        _captureAndStoreCookies(response.headers);
      }
      return success;
    } catch (e) {
      log('✗ Login error: ${e.toString()}', error: e, name: 'Auth');
      return false;
    }
  }
  
  /// Authenticate user with mobile number and password
  Future<bool> loginWithMobilePassword(
      String hostUrl, String mobileNo, String password) async {
    await _setHostUrl(hostUrl);
    try {
      final response = await dio.post(
        "/api/method/lms_360ithub.utils.custom_login.login_with_mobile_password",
        data: {'mobile_no': mobileNo, 'password': password},
      );

      final success = _isLoginSuccessful(response);
      if (success) {
        _captureAndStoreCookies(response.headers);
      }
      return success;
    } catch (e) {
      log('✗ Login error: ${e.toString()}', error: e, name: 'Auth');
      return false;
    }
  }

  /// New registration
  Future<Response<dynamic>> newRegistration({
    required String studentName,
    required String email,
    required String mobileNo,
    required String password,
    required String hostUrl,
  }) async {
    try {
      await _setHostUrl(hostUrl);
      final response = await dio.post(
        '/api/method/lms_360ithub.utils.custom_login.new_registration',
        data: {
          'student_name': studentName,
          'email': email,
          'mobile_no': mobileNo,
          'password': password,
        },
      );
      if (response.statusCode != 200) {
        await logout();
      }
      return response;
    } on DioException catch (e) {
      log('✗ newRegistration error: ${e.message}', error: e, name: 'Auth');
      rethrow;
    }
  }

  Future<Response<dynamic>> forgotPassword(
      {required String hostUrl, required Map<dynamic, dynamic> data}) async {
    try {
      await _setHostUrl(hostUrl);
      final response = await post(
          '/api/method/lms_360ithub.api.user_forget_password',
          data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Check if login response indicates success
  bool _isLoginSuccessful(Response response) {
    if (response.statusCode != 200) return false;
    return true;
  }

  /// Clear user session and stored data
  Future<void> logout() async {
    dio.options.headers.remove('Cookie');
    _storage.remove(_cookieKey);
    _storage.remove(_hostKey);
  }

  // ==================== PRIVATE HELPER METHODS ====================

  /// Capture and store cookies from response headers
  Future<void> _captureAndStoreCookies(Headers headers) async {
    final setCookies = headers.map['set-cookie'];
    if (setCookies != null && setCookies.isNotEmpty) {
      _updateCookies(setCookies);
    }
  }

  /// Set and store host URL
  Future<void> _setHostUrl(String url) async {
    final formatted =
        url.endsWith('/') ? url.substring(0, url.length - 1) : url;
    dio.options.baseUrl = formatted;
    await _storage.write(_hostKey, formatted);
  }

  @override
  void onClose() {
    dio.close();
    super.onClose();
  }
}
