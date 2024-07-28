import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/entity/get_all_car_model.dart';
import '../data/repository/main_repo.dart';

class MainVm with ChangeNotifier {
  List<GetAllCarModel> allCars = [];
  ScrollController scrollController = ScrollController();
  int limit = 10; // default limit
  int page = 0;

  // Parameters
  String? searchParameter;
  String? searchValue;

  MainVm() {
    // scrollController.addListener();
  }

  Future<void> getData() async {
    List<GetAllCarModel> newCars = await MainRepo().getAllCars(
          limit: limit,
          searchParameter: searchParameter,
          searchValue: searchValue,
        ) ??
        [];
    allCars.addAll(newCars);
  }

  void searchCars(
      {String? searchParameter, String? searchValue, int? limit}) async {
    this.searchParameter = searchParameter;
    this.searchValue = searchValue;
    this.limit = limit ?? this.limit;
    allCars.clear();

    await getData();
    notifyListeners();
  }

  @override
  void dispose() {
    // scrollController.removeListener();
    scrollController.dispose();
    super.dispose();
  }
}
