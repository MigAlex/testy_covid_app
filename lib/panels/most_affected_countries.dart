import 'package:flutter/material.dart';

class MostAffectedPanel extends StatelessWidget {
  final List countryData;

  const MostAffectedPanel({Key key, this.countryData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(thickness: 2,),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(children: [
              Text('#${index+1}'),
              SizedBox(width: 5),
              Image.network(countryData[index]['countryInfo']['flag'], height: 25, width: 55,),
              SizedBox(width: 10),
              Text(countryData[index]['country'], style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(width: 10),
              Text('Deaths: ' + countryData[index]['deaths'].toString(), style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))
            ],),
          );
        },
      ),
    );
  }
}
