import 'package:flutter/material.dart';

class VenuePage extends StatelessWidget {
  static const venueRouteName = '/venue';
  final String title;
  final String description;

  VenuePage(this.title, this.description);

  Divider getDivider() {return const Divider(height: 40);}

  @override
  Widget build(BuildContext context) {
    double rating = 3.5;
    int ratingCount = 1337;
    double sizedBoxWidth = 10.0;
    String location = "Norrmalm, Stockholm, Sweden";

    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(title),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(

          children: [
            Column(
              children: [
                SizedBox(width: sizedBoxWidth),
                Container(
                  child: Row(
                    children: [
                      Icon(Icons.star),
                      SizedBox(width: sizedBoxWidth),
                      Text("${rating.toString()} ($ratingCount)"),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  child: Row(
                    children: [
                      Icon(Icons.pin_drop),
                      SizedBox(width: sizedBoxWidth),
                      Text(location),
                    ],
                  ),
                ),
                SizedBox(width: sizedBoxWidth),
              ],
            ),
            getDivider(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(description),
            ),
          getDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatButton(
                onPressed: () {},
                child: Text("Hämta offert"),
              ),
              FlatButton(
                onPressed: () {},
                child: Text("Starta chat"),
              )
            ],
          )
          ],
        ),
      ),
    );
  }
}
