import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  List<List<dynamic>> supplierCollection = [
    [
      "assets/images/flowers1.jpg",
      "Gunillas blomsterbutik",
      "Har du fått fakturan än?",
      "10:01"
    ],
    [
      "assets/images/flowers2.jpg",
      "Von Barmhertigs blommor",
      "Vi ger tyvärr inte rabbat på ordrar under 10 000 SEK",
      "2020-06-15"
    ],
    [
      "assets/images/flowers3.jpg",
      "Roséns",
      "ja, vi kan tänka oss det",
      "yesterday"
    ]
  ];




  @override
  Widget build(BuildContext context) {

    ListTile getListTile(String supplierName, String lastMessage, String imageAddress, String lastMessageTime) {
      return ListTile(
        onTap: () {
          Navigator.of(context).pushNamed('/chat', arguments: [supplierName]);
        },
        leading: CircleAvatar(backgroundImage: AssetImage(imageAddress),),
        title: Text(
          supplierName,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
        ),
        subtitle: Text(lastMessage),
        trailing: Text(lastMessageTime),
      );
    }

    List<ListTile> inputs = supplierCollection.map((e) =>
        getListTile(e[1], e[2], e[0], e[3])).toList();

    return Container(
      //color: Color.fromRGBO(222, 2, 1, 0.5),
      child: new ListView.separated(
        separatorBuilder: (_, __) => Divider(height: 5),
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
