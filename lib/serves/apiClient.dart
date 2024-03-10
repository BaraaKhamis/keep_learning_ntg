
import 'dart:convert' as convert;

import 'package:demo/model/LeaguesModel.dart';
import 'package:demo/model/contreModel.dart';
import 'package:http/http.dart' as http;

Future<dynamic> apiClient() async {
  var response = await http.get(Uri.parse("https://www.thesportsdb.com/api/v1/json/3/all_countries.php"),
      headers: {
    "Content-Type":"application/json"
  });
  if (response.statusCode == 200) {
    return convert.jsonDecode(response.body) as Map<String, dynamic>;

  } else {
    print('Request failed with status: ${response.statusCode}.');
    throw 'error';
  }
}

Future<dynamic> apiClient2(CountriesModel countriesModel) async {
  var response = await http.get(Uri.parse("https:// www.thesportsdb"
      ".com/api/v1/json/3/search_all_leagues.php?c=${countriesModel
      .countries[0].nameEn}"),
headers: {
    "Content-Type":"application/json"
  });
  if (response.statusCode == 200) {
    return convert.jsonDecode(response.body) as Map<String, dynamic>;

  } else {
    print('Request failed with status: ${response.statusCode}.');
    throw 'error';
  }
}