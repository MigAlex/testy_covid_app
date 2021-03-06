import 'dart:convert';

import 'package:covid_app/pages/country_page.dart';
import 'package:covid_app/panels/info_panel.dart';
import 'package:covid_app/panels/most_affected_countries.dart';
import 'package:covid_app/panels/worldwide_panel.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'data_source.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map worldData;
  List countryData;

  fetchWorldWildeData() async {
    http.Response response = await http.get("https://corona.lmao.ninja/v2/all");

    setState(() {
      worldData = json.decode(response.body);
    });
  }

  fetchCountryData() async {
    http.Response response =
        await http.get("https://corona.lmao.ninja/v2/countries?sort=cases");

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
        actions: [myLightButton(context)],
        title: Text('COVID-19 TRACKER'),
        centerTitle: true,
      ),
      drawer: InfoPanel(),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          myHeaderContainer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Worldwide",style: myHomeTextStyle()),
                myRegionalButton(context)
              ],
            ),
          ),
          worldData == null
              ? CircularProgressIndicator()
              : WorldWidePanel(worldData: worldData),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Center(child: Text("Most affected Countries", style: myHomeTextStyle())),
          ),
          SizedBox(height: 10),
          countryData == null
              ? Container()
              : MostAffectedPanel(countryData: countryData),
          InfoPanel(),
          SizedBox(height: 20),
          Center(
              child: Text('We are together in the fight',style: myHomeTextStyle())),
          SizedBox(height: 50)
        ],
      )),
    );
  }
}

Container myHeaderContainer() {
  return Container(
    height: 100,
    alignment: Alignment.center,
    padding: EdgeInsets.all(19),
    decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.brown, Colors.blueGrey], stops: [0.0, 0.7])),
    child: Text(DataSource.quote,
        style: TextStyle(
            color: Colors.orange[800],
            fontWeight: FontWeight.bold,
            fontSize: 16)),
  );
}

IconButton myLightButton(BuildContext context) {
  return IconButton(
      icon: Icon(Theme.of(context).brightness == Brightness.light
          ? Icons.lightbulb_outline
          : Icons.highlight),
      onPressed: () {
        DynamicTheme.of(context).setBrightness(
            Theme.of(context).brightness == Brightness.light
                ? Brightness.dark
                : Brightness.light);
      });
}

Widget myRegionalButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CountryPage()));
    },
    child: Container(
        decoration: BoxDecoration(
            color: primaryBlack, borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text("Regional",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        )),
  );
}

TextStyle myHomeTextStyle(){
  return TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
}