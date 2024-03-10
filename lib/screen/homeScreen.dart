
import 'dart:convert';

import 'package:demo/model/contreModel.dart';
import 'package:demo/serves/apiClient.dart';
import 'package:flutter/material.dart';

import '../constant/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CountriesModel? countriesModel;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    isLoading  = true ;

    fetchData();

    isLoading = false;
    super.initState();
  }
  void fetchData()async{
    var body=await apiClient();
    countriesModel=  CountriesModel.fromJson(body);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Countries"),
      ),

      body: getListCountries(context,countriesModel),
    );
  }


  getListCountries(context,countriesModel){
    return
        Column(
          children: [
        getSearchCountries(),
        SizedBox(height: 20,),
        countriesModel==null?const Center(child: CircularProgressIndicator
            (),):getBuildListView(countriesModel)
          ],
        );



  }

  getSearchCountries(){
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: SizedBox(
        height: 45,
        width: 360,
        child: TextField(
          style: TextStyle(color: Colors.black),
          // GoogleFonts.poppins(
          //   color: const Color(0xff020202),
          //   fontSize: 20,
          //   fontWeight: FontWeight.w400,
          //   letterSpacing: 0.5,
          // ),
          // onChanged: _handleSearch,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xfff1f1f1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            hintText: "Search for Country",
            hintStyle:TextStyle(color: Colors.grey),
            // GoogleFonts.poppins(
            //     color: const Color(0xffb2b2b2),
            //     fontSize: 20,
            //     fontWeight: FontWeight.w400,
            //     letterSpacing: 0.5,
            //     decorationThickness: 6),
            prefixIcon: const Icon(Icons.search),
            prefixIconColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
