import 'dart:convert';
import 'dart:ui';

import 'package:demo/screen/leagues.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TeamsListPage extends StatefulWidget {
  final String countryName;
  final String strSport;

  TeamsListPage({required this.countryName,required this.strSport,});

  @override
  _TeamsListPageState createState() => _TeamsListPageState();
}
class _TeamsListPageState extends State<TeamsListPage> {
  List<dynamic> teams = [];
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
    http.get(Uri.parse
      ("https://www.thesportsdb.com/api/v1/json/3/search_all_teams.php?s=${widget.strSport}&c=${widget.countryName}"),
  // ("https://www.thesportsdb"".com/api/v1/json/3/search_all_teams.php?s=${widget.strSport}${widget.countryName}"),
        // "https://www.thesportsdb"
        //     ".com/api/v1/json/3/search_all_seasons.php?id=${widget.strSport}${widget.countryName}"),
        headers: {
          "Content-Type":"application/json"
        }).then((value) {
      final data = jsonDecode(value.body);
      teams = data['teams'];
      leagueSearch=teams;
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
              title: Text(leagueSearch[index]["strTeam"],
              ),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => TeamsListPage(
                //       countryName: leagueSearch[index]["name_en"],
                //     ),
                //   ),
                // );
              },
            );
        },
      ),
    );
  }
  void onSearchChanged(String value) {
    setState(() {
      if(value.isNotEmpty) {
        leagueSearch = teams.where((element) =>
            element["strTeam"].toLowerCase().contains(value.toLowerCase()))
            .toList();
      }else{
        leagueSearch=teams;
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
