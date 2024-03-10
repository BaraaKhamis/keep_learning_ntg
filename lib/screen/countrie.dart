import 'dart:convert';
import 'dart:ui';

import 'package:demo/screen/leagues.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SportsListPage extends StatefulWidget {
  @override
  _SportsListPageState createState() => _SportsListPageState();
}
class _SportsListPageState extends State<SportsListPage> {
  List<dynamic> countries = [];
  bool isLoading = false;
  String searchText = '';
  TextEditingController searchController = TextEditingController();
  List<dynamic> leagueSearch = [];
  @override
  void initState() {
    super.initState();
    fetchCountries();
  }
  fetchCountries() async {
    setState(() {
      isLoading = true;
    });
    var response = await
    http.get(Uri.parse("https://www.thesportsdb.com/api/v1/json/3/all_countries.php"),
        headers: {
      "Content-Type":"application/json"
    }).then((value) {
      final data = jsonDecode(value.body);
      countries = data['countries'];
      leagueSearch=countries;
    });
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('Sports App'),
      ),
      body: Column(
        children: [
          getSearchCountries(),
          // SizedBox(height: 20,),
          getCountries()
        ],
      )

    );
  }

getCountries(){
    return  isLoading ? Center(
      child: CircularProgressIndicator(),
    )
        : Expanded(
          child: ListView.builder(
      itemCount: leagueSearch.length,
      itemBuilder: (context, index) {
        var borderRadius = const BorderRadius.only(topRight: Radius.circular
          (32), bottomRight: Radius.circular(32),);
        return
            ListTile(
              shape: RoundedRectangleBorder(borderRadius: borderRadius),
              selectedTileColor: Colors.orange[100],
            title: Text(leagueSearch[index]["name_en"],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LeaguesListPage(
                    countryName: leagueSearch[index]["name_en"],
                  ),
                ),
              );
            },
          );
      },
    ),
        );
}
  void onSearchChanged(String value) {
    setState(() {
      if(value.isNotEmpty) {
        leagueSearch = countries.where((element) =>
            element["name_en"].toLowerCase().contains(value.toLowerCase()))
            .toList();
      }else{
        leagueSearch=countries;
      }
    });
  }
  getSearchCountries(){
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: SizedBox(
        height: 45,
        width: 360,
        child: TextField(
          controller: searchController,
          style: TextStyle(color: Colors.black),
          onChanged: onSearchChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xfff1f1f1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color:Colors.black ,width:1.0  ),
            ),
            hintText: "Search for Country",
            hintStyle:TextStyle(color: Colors.grey),

            prefixIcon: const Icon(Icons.search),
            prefixIconColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
