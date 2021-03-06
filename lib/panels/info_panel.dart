import 'package:covid_app/data_source.dart';
import 'package:covid_app/pages/faqs.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FAQPage()));
      },
      child: Container(
        child: Column(
          children: [
            basicContainer('FAQs'),
            GestureDetector(
              onTap: () {
                launch(
                    'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/donate');
              },
              child: basicContainer('DONATE'),
            ),
            GestureDetector(
                onTap: () {
                  launch(
                      'https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public/myth-busters');
                },
                child: basicContainer('MYTH BUSTERS')),
          ],
        ),
      ),
    );
  }
}

Container basicContainer(String myText) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    color: primaryBlack,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$myText', style: infoTextStyle()),
        Icon(Icons.arrow_forward, color: Colors.white),
      ],
    ),
  );
}

TextStyle infoTextStyle() {
  return TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18);
}
