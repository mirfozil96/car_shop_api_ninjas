import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';


class ApiInterceptor extends InterceptorContract {

  @override
  Future<http.BaseRequest> interceptRequest({required http.BaseRequest request}) async {
    if (kDebugMode) {
      log(
          "[Interceptor]---------ON_REQUEST(${request.method})------------------"
              "\nURL: ${request.url}\n\n"
      );
    }
    return request;
  }

  @override
  Future<http.BaseResponse> interceptResponse({required http.BaseResponse response}) async{
    if (kDebugMode) {
      log(
          "[Interceptor]---------ON_RESPONSE(${response.statusCode})------------------"
              "\nREASON PHRASE: ${response.reasonPhrase}\n\n"
      );
    }
    return response;
  }

}
