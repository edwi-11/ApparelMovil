import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../errors/app_exception.dart';

class ApiClient {
  final http.Client _client = http.Client();
  final String? Function()? _getToken;

  ApiClient([this._getToken]);

  Future<dynamic> get(String path, {Map<String, String>? query}) async =>
      _send('GET', path, query, null);
  Future<dynamic> post(String path, {Object? body}) async =>
      _send('POST', path, null, body);
  Future<dynamic> put(String path, {Object? body}) async =>
      _send('PUT', path, null, body);
  Future<dynamic> delete(String path) async =>
      _send('DELETE', path, null, null);

  Future<dynamic> _send(
    String method,
    String path,
    Map<String, String>? query,
    Object? body,
  ) async {
    final baseUrl = ApiConstants.instance.baseUrl;
    final uri = Uri.parse('$baseUrl$path').replace(queryParameters: query);
    final headers = {'Content-Type': 'application/json'};

    final token = _getToken?.call();
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final request = http.Request(method, uri)..headers.addAll(headers);
    if (body != null) {
      request.body = jsonEncode(body);
    }

    final http.Response response;
    try {
      response = await _client
          .send(request)
          .timeout(ApiConstants.timeoutDuration)
          .then(http.Response.fromStream);
    } on TimeoutException {
      throw const NetworkException('Tiempo de espera agotado. Intenta de nuevo.');
    } on http.ClientException {
      throw const NetworkException();
    }

    if (response.statusCode == 401) {
      throw const UnauthorizedException();
    }

    if (response.statusCode == 404) throw const NotFoundException();

    return _decode(response);
  }

  dynamic _decode(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ServerException('La petición falló', statusCode: response.statusCode);
    }

    if (response.body.isEmpty) return null;

    try {
      return jsonDecode(response.body);
    } on FormatException {
      throw const ParsingException();
    }
  }

  void dispose() => _client.close();
}