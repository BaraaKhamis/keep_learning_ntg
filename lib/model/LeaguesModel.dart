// To parse this JSON data, do
//
//     final leaguesModel = leaguesModelFromJson(jsonString);

import 'dart:convert';

LeaguesModel leaguesModelFromJson(String str) => LeaguesModel.fromJson(json.decode(str));

String leaguesModelToJson(LeaguesModel data) => json.encode(data.toJson());

class LeaguesModel {
  List<Map<String, String?>> countries;

  LeaguesModel({
    required this.countries,
  });

  factory LeaguesModel.fromJson(Map<String, dynamic> json) => LeaguesModel(
    countries: List<Map<String, String?>>.from(json["countries"].map((x) => Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
  );

  Map<String, dynamic> toJson() => {
    "countries": List<dynamic>.from(countries.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
  };
}
