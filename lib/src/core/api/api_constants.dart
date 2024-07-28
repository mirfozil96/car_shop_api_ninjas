final class ApiConstants {
  // baseUrl
  static const baseUrl = "api.api-ninjas.com";

  // apis
  static const apiGetAllImages = '/v1/cars';

  // headers
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'X-Api-Key':
        'l0t5AibvtUfLNb+scpu/2g==EtcIt1wtXHeMXdER' // Replace with your actual API key
  };

  static Map<String, String> paramsGetAllImages({
    required String limit,
    String? searchParameter,
    String? searchValue,
  }) {
    final params = {
      'limit': limit,
    };
    if (searchParameter != null && searchValue != null) {
      params[searchParameter] = searchValue;
    }
    return params;
  }
}
