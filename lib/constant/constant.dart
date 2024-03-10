



import 'package:demo/model/LeaguesModel.dart';
import 'package:flutter/material.dart';

import '../model/contreModel.dart';
import '../screen/secondscr.dart';

getBuildListView(CountriesModel countriesModel){
 return Expanded(
   child: ListView.builder(
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // isLoading== true ?CircularProgressIndicator():
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)
                  => SecScreen(countriesModel) ));
                },
                child: Container(
                  width:double.infinity,
                  color: Colors.grey[100],
                    child: Text ("${countriesModel?.countries[index].nameEn}")),
              ),
            ),
          ],
        );
      },
      itemCount: countriesModel?.countries.length,

    ),
 );
}
getBuildList2View(CountriesModel leaguesModel){
  return Expanded(
    child: ListView.builder(
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // isLoading== true ?CircularProgressIndicator():
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)
                  => Container() ));
                },
                child: Container(
                    width:double.infinity,
                    color: Colors.grey[100],
                    child: Text ("${leaguesModel?.countries[index]}")),
              ),
            ),
          ],
        );
      },
      itemCount: leaguesModel?.countries.length,

    ),
  );
}