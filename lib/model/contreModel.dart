// To parse this JSON data, do
//
//     final countriesModel = countriesModelFromJson(jsonString);

import 'dart:convert';

CountriesModel countriesModelFromJson(String str) => CountriesModel.fromJson(json.decode(str));

String countriesModelToJson(CountriesModel data) => json.encode(data.toJson());

class CountriesModel {
  List<Country> countries;

  CountriesModel({
    required this.countries,
  });

  factory CountriesModel.fromJson(Map<String, dynamic> json) => CountriesModel(
    countries: List<Country>.from(json["countries"].map((x) => Country.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
  };
}

class Country {
  String nameEn;

  Country({
    required this.nameEn,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    nameEn: json["name_en"],
  );

  Map<String, dynamic> toJson() => {
    "name_en": nameEn,
  };
}
