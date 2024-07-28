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
  Map<String, String?> filters = {};

  MainVm() {
    // scrollController.addListener();
  }

  Future<void> getData() async {
    List<GetAllCarModel> newCars = await MainRepo().getAllCars(
          limit: limit,
          filters: filters,
        ) ??
        [];
    allCars.addAll(newCars);
  }

  void searchCars({Map<String, String?>? filters, int? limit}) async {
    this.filters = filters ?? this.filters;
    this.limit = limit ?? this.limit;
    allCars.clear();

    await getData();
    notifyListeners();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
