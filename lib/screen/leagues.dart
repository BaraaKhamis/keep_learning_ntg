

import 'dart:convert';

import 'package:demo/screen/saision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LeaguesListPage extends StatefulWidget {
  final String countryName;
  LeaguesListPage({required this.countryName});
  @override
  _LeaguesListPageState createState() => _LeaguesListPageState();
}
class _LeaguesListPageState extends State<LeaguesListPage> {
  List<dynamic> leagues = [];
  bool isLoading = false;
  String searchText = '';
  TextEditingController searchController = TextEditingController();
  List<dynamic> leagueSearch = [];
  @override
  void initState() {
    super.initState();
    fetchLeagues();
  }

  Future<void> fetchLeagues() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(
      Uri.parse(
          'http://www.thesportsdb.com/api/v1/json/3/search_all_leagues.php?c=${widget
              .countryName}'),
    ).then((value) {
      final data = jsonDecode(value.body);
        leagues = data['countries'];
      leagueSearch=leagues;
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
        body:  Column(
          children: [
            getSearchCountries(),
            // SizedBox(height: 20,),
            getLeagues()
          ],
        )
        );}
  void onSearchChanged(String value) {
    setState(() {
      if(value.isNotEmpty) {
        leagueSearch = leagues.where((element) =>
            element["strLeague"].toLowerCase().contains(value.toLowerCase()))
            .toList();
      }else{
        leagueSearch=leagues;
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
            fillColor:  const Color(0xfff1f1f1),
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

  getLeagues(){
    return
      isLoading
        ? Center(
      child: CircularProgressIndicator(),
    )
        : Expanded(
          child: ListView.builder(
      itemCount: leagueSearch.length,
      itemBuilder: (context, index) {
          return
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeasonsListPage(
                        idLeague: leagueSearch[index]["idLeague"],
                        strSport: leagueSearch[index]["strSport"],
                        countryName: widget.countryName,
                        /*leagueSearch[index]["idLeague"]*/
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(20),
                    // color: Colors.grey,
                    border:Border.all(color: Colors.grey,width: 1.0,
                        style:
                    BorderStyle.solid)
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage
                          ("${leagueSearch[index]["strBadge"]}",scale: 20),),
                      // CircleAvatar(
                      //   child: ClipOval(
                      //     child: Image.network(
                      //       "${leagueSearch[index]["strBadge"]}",  // fit: BoxFit
                      //       // .cover,
                      //       width: 300,
                      //       height: 300,
                      //     ),),),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("${leagueSearch[index]["strCountry"]}",style: TextStyle(fontSize: 18,fontWeight:
                            FontWeight
                                .bold),),
                            Text("${leagueSearch[index]["strLeague"]}",style: TextStyle
                              (color: Colors.grey),),
                            Text("${leagueSearch[index]["strCurrentSeason"]}",style:
                            TextStyle(color: Colors.grey),),
                            Text("${leagueSearch[index]["intFormedYear"]}",style:
                            TextStyle(color: Colors.grey),),
                            Text("${leagueSearch[index]["dateFirstEvent"]}",style:
                            TextStyle(color: Colors.grey),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );

            /*ListTile(
            title: Text("${leagues[index]["strLeague"]}"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LeaguesListPage(
                    countryName: leagues[index],
                  ),
                ),
              );
            },
          );*/
      },
    ),
        );

  }










        // isLoading
        //     ? Center(
        //   child: CircularProgressIndicator(),
        // )
        //     : ListView.builder(
        //   itemCount: leagues.length,
        //   itemBuilder: (context, index) {
        //     return ListTile(
        //       title: Text("${leagues[index]["strLeague"]}"),
        //       onTap: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => LeaguesListPage(
        //               countryName: leagues[index],
        //             ),
        //           ),
        //         );
        //       },
        //     );
        //   },
        // ),


}
