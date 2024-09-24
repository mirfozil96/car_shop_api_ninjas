import 'dart:convert';
import 'package:http_interceptor/http/intercepted_http.dart';
import 'api_constants.dart';
import 'api_interceptor.dart';

class Api {
  static final http = InterceptedHttp.build(interceptors: [
    ApiInterceptor(),
  ]);

  static Future<String?> get(String api, Map<String, String> params) async {
    final url = Uri.http(ApiConstants.baseUrl, api, params);
    final response = await http.get(url, headers: ApiConstants.headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> post(String api, Map<String, dynamic> body) async {
    Uri url = Uri.http(ApiConstants.baseUrl, api);
    final response = await http.post(url,
        headers: ApiConstants.headers, body: jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> put(
      String api, Map<String, dynamic> body, Map<String, dynamic> param) async {
    final url = Uri.http(ApiConstants.baseUrl, api, param);
    final response = await http.put(url,
        body: jsonEncode(body), headers: ApiConstants.headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<String?> patch(
      String api, Map<String, String> params, Map<String, dynamic> body) async {
    final url = Uri.http(ApiConstants.baseUrl, api);
    final response = await http.patch(url,
        headers: ApiConstants.headers, body: jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> delete(String api, Map<String, String> params) async {
    final url = Uri.http(ApiConstants.baseUrl, api, params);
    final response = await http.delete(url, headers: ApiConstants.headers);
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      return response.body;
    }
    return null;
  }
}
