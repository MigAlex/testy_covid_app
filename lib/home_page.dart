import 'dart:convert';

import 'package:covid_app/pages/country_page.dart';
import 'package:covid_app/panels/info_panel.dart';
import 'package:covid_app/panels/most_affected_countries.dart';
import 'package:covid_app/panels/worldwide_panel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'data_source.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map worldData;

  fetchWorldWildeData() async {
    http.Response response = await http.get("https://corona.lmao.ninja/v2/all");

    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List countryData;

  fetchCountryData() async {
    http.Response response =
        await http.get("https://corona.lmao.ninja/v2/countries");

    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchWorldWildeData();
    fetchCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID-19 TRACKER'),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            alignment: Alignment.center,
            padding: EdgeInsets.all(19),
            color: Colors.orange[100],
            child: Text(DataSource.quote,
                style: TextStyle(
                    color: Colors.orange[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Worldwide",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CountryPage()));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: primaryBlack,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text("Regional",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      )),
                ),
              ],
            ),
          ),
          worldData == null
              ? CircularProgressIndicator()
              : WorldWidePanel(worldData: worldData),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text("Most affected Countries",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 10),
          countryData == null
              ? Container()
              : MostAffectedPanel(countryData: countryData),
          InfoPanel(),
          SizedBox(height: 20),
          Center(
              child: Text('We are together in the fight',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
          SizedBox(height: 50)
        ],
      )),
    );
  }
}