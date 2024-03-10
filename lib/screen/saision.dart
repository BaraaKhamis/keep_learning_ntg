import 'dart:convert';
import 'dart:ui';

import 'package:demo/screen/leagues.dart';
import 'package:demo/screen/teams.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SeasonsListPage extends StatefulWidget {
  final String idLeague;
  final String countryName;
  final String strSport;

  SeasonsListPage({required this.idLeague,required this.countryName,required this.strSport,});

  @override
  _SeasonsListPageState createState() => _SeasonsListPageState();
}
class _SeasonsListPageState extends State<SeasonsListPage> {
  List<dynamic> seasons = [];
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
    http.get(Uri.parse("https://www.thesportsdb"
        ".com/api/v1/json/3/search_all_seasons.php?id=${widget.idLeague}"),
        headers: {
          "Content-Type":"application/json"
        }).then((value) {
      final data = jsonDecode(value.body);
      seasons = data['seasons'];
      leagueSearch=seasons;
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
          title: Text(widget.countryName),
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
          var borderRadius = const BorderRadius.only(topRight: Radius.circular(32), bottomRight: Radius.circular(32));
          return
            ListTile(
              shape: RoundedRectangleBorder(borderRadius: borderRadius),
              selectedTileColor: Colors.orange[100],
              title: Text(leagueSearch[index]["strSeason"],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TeamsListPage(
                      countryName: widget.countryName,
                      // leagueSearch[index]["name_en"],
                      strSport: widget.strSport,
                      // leagueSearch[index]["strSport"],
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
        leagueSearch = seasons.where((element) =>
            element["strSeason"].toLowerCase().contains(value.toLowerCase()))
            .toList();
      }else{
        leagueSearch=seasons;
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
              borderRadius: BorderRadius.circular(8),
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
