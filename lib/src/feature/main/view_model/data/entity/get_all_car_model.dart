// To parse this JSON data, do
//
//     final getAllCarModel = getAllCarModelFromJson(jsonString);

import 'dart:convert';

List<GetAllCarModel> getAllCarModelFromJson(String str) =>
    List<GetAllCarModel>.from(
        json.decode(str).map((x) => GetAllCarModel.fromJson(x)));

String getAllCarModelToJson(List<GetAllCarModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllCarModel {
  final int? cityMpg;
  final String? getAllImageModelClass;
  final int? combinationMpg;
  final int? cylinders;
  final double? displacement;
  final String? drive;
  final FuelType? fuelType;
  final int? highwayMpg;
  final String? make;
  final String? model;
  final Transmission? transmission;
  final int? year;

  GetAllCarModel({
    this.cityMpg,
    this.getAllImageModelClass,
    this.combinationMpg,
    this.cylinders,
    this.displacement,
    this.drive,
    this.fuelType,
    this.highwayMpg,
    this.make,
    this.model,
    this.transmission,
    this.year,
  });

  factory GetAllCarModel.fromJson(Map<String, dynamic> json) => GetAllCarModel(
        cityMpg: json["city_mpg"],
        getAllImageModelClass: json["class"],
        combinationMpg: json["combination_mpg"],
        cylinders: json["cylinders"],
        displacement: json["displacement"]?.toDouble(),
        drive: json["drive"],
        fuelType: fuelTypeValues.map[json["fuel_type"]]!,
        highwayMpg: json["highway_mpg"],
        make: json["make"],
        model: json["model"],
        transmission: transmissionValues.map[json["transmission"]]!,
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "city_mpg": cityMpg,
        "class": getAllImageModelClass,
        "combination_mpg": combinationMpg,
        "cylinders": cylinders,
        "displacement": displacement,
        "drive": drive,
        "fuel_type": fuelTypeValues.reverse[fuelType],
        "highway_mpg": highwayMpg,
        "make": make,
        "model": model,
        "transmission": transmissionValues.reverse[transmission],
        "year": year,
      };
}

enum FuelType { gas }

final fuelTypeValues = EnumValues({"gas": FuelType.gas});

enum Transmission { A }

final transmissionValues = EnumValues({"a": Transmission.A});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
