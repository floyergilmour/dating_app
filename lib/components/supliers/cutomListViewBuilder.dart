import 'package:flutter/material.dart';
import 'package:school_app/components/constants.dart';
import 'package:school_app/user/supplier.dart';

class CustomListViewBuilder extends StatelessWidget {
  List<List<String>> supplierCollection = [
    [
      "assets/images/flowers1.jpg",
      "Gunnilas blommsterbutik",
      "Small shop from Stockholm with a personal touch"
    ],
    [
      "assets/images/flowers2.jpg",
      "Von Barmhertigs blommor",
      "The most high end bridal shop in Sweden"
    ],
    [
      "assets/images/flowers3.jpg",
      "Roséns",
      "Family owned bridal flower shop"
    ]
  ];

  @override
  Widget build(BuildContext context) {
    
    Card getCard(String title, String description, String imageAddress) {
      return Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CARD_ROUNDED_BORDER_RADIOUS),
        ),
        elevation: CARD_ELEVATION,
        //clipBehavior: Clip.antiAlias,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.of(context).pushNamed('/venue', arguments: [title]);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 0,
                child: AspectRatio(
                  aspectRatio: 3 / 2,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Image.asset(
                      imageAddress,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.star),
                      title: Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                      ),
                      subtitle: Text(description),

                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    
    List<Card> inputs =
        supplierCollection.map((e) => getCard(e[1], e[2], e[0])).toList();
    return Container(
      //color: Color.fromRGBO(222, 2, 1, 0.5),
      child: new ListView.builder(
        itemCount: supplierCollection.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return Column(
            children: [
              inputs[index]
            ],
          );
        },
      ),
    );
  }
}