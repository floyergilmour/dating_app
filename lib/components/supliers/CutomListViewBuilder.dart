import 'package:flutter/material.dart';

class CustomListViewBuilder extends StatelessWidget {
  List<String> items = ["Gunnillas Blomster Affär", "My Big Day"];
  Map<String, List<String>> supplierCollection = {
    "assets/images/harvard.jpg": ["Image 1", "Image 2", "Image 3"],
    "assets/images/hvitfeldtska.png": ["Image 4", "Image 5", "Image 6"],
    "assets/images/mockProfileImage.jpeg": ["Image 1", "Image 2", "Image 3"],
    "assets/images/harvard.jpg": ["Image 1", "Image 2", "Image 3"],
    "assets/images/hvitfeldtska.png": ["Image 4", "Image 5", "Image 6"],
    "assets/images/mockProfileImage.jpeg": ["Image 1", "Image 2", "Image 3"],
  };

  @override
  Widget build(BuildContext context) {
    Card getMainSupplierCard(String textInput, {String imageUrl}) {
      return Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.of(context).pushNamed('/venue', arguments: [textInput]);
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                children: [
                  if (imageUrl?.isNotEmpty ?? false)
                    Image.asset(
                      imageUrl,
                      fit: BoxFit.fitHeight,
                    )
                  else
                    Text(textInput)
                ],
              ),
            ),
          ),
        ),
      );
    }

    List<List<Card>> createListOfCards(
        Map<String, List<String>> inputCollection) {
      List<List<Card>> masterList = [];
      Map<String, List<Card>> cards = inputCollection.map((key, value) =>
          MapEntry(
              key,
              [getMainSupplierCard(key, imageUrl: key)] +
                  value.map((elements) => getMainSupplierCard(elements)).toList()));
      cards.forEach((k, v) => masterList.add(v));
      return masterList;
    }

    var input = createListOfCards(supplierCollection);
    return Container(
      child: new ListView.builder(
        //shrinkWrap: true,
        itemCount: supplierCollection.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.width,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: input[index],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
