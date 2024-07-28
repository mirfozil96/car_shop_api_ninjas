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
    String? searchParameter,
    String? searchValue,
  }) async {
    String api = ApiConstants.apiGetAllImages;
    Map<String, String> params = ApiConstants.paramsGetAllImages(
      limit: limit.toString(),
      searchParameter: searchParameter,
      searchValue: searchValue,
    );

    String? result = await Api.GET(api, params);
    if (result != null) {
      List<GetAllCarModel> getAllCarModels = getAllCarModelFromJson(result);
      return getAllCarModels;
    } else {
      return null;
    }
  }
}
