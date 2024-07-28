import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../riverpod.dart';
import '../../../../../core/api/api.dart';
import '../../../../../core/api/api_constants.dart';
import '../entity/get_all_car_model.dart';

// Define the repository provider
final mainFetchData = FutureProvider((ref) async {
  final getResult = ref.read(mainVM);
  return getResult.getData();
});

class MainRepo {
  Future<List<GetAllCarModel>?> getAllCars({
    required int limit,
    Map<String, String?>? filters,
  }) async {
    String api = ApiConstants.apiGetAllImages;
    Map<String, String> params = {
      'limit': limit.toString(),
    };

    if (filters != null) {
      filters.forEach((key, value) {
        if (value != null && value.isNotEmpty) {
          params[key] = value;
        }
      });
    }

    String? result = await Api.GET(api, params);
    if (result != null) {
      List<GetAllCarModel> getAllCarModels = getAllCarModelFromJson(result);
      return getAllCarModels;
    } else {
      return null;
    }
  }
}
