import 'package:demo/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/LeaguesModel.dart';
import '../model/contreModel.dart';
import '../serves/apiClient.dart';

class SecScreen extends StatefulWidget {
  CountriesModel? leaguesModel;

  SecScreen(this.leaguesModel) ;


  @override
  State<SecScreen> createState() => _SecScreenState();
}

class _SecScreenState extends State<SecScreen> {

  @override
  void initState() {
    // TODO: implement initState


    fetchData(widget.leaguesModel,);

    super.initState();
  }
  void fetchData(leaguesModel,)async{
    var body=await apiClient2(leaguesModel,);
    widget.leaguesModel=  CountriesModel.fromJson(body);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(body: getListCountries(context,widget.leaguesModel),);

  }
  getListCountries(context,leaguesModel) {
    return
      Column(
        children: [
          getSearchCountries(),
          SizedBox(height: 20,),
          leaguesModel == null ? const Center(child: CircularProgressIndicator
            (),) : getBuildList2View(leaguesModel)
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
