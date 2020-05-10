import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:school_app/components/CriteriaTag.dart';
import 'package:school_app/extensions/extensions.dart';


class ChipsInputBuilder extends StatelessWidget {

  final String title;
  final List<String> userItemList;
  final Function onChangedFunction;

  ChipsInputBuilder({this.title, this.userItemList, this.onChangedFunction});

  @override
  Widget build(BuildContext context) {

    const ideologiesCriteriaTagsMockData = <CriteriaTag>[
      CriteriaTag("Communism", 'https://f0.pngfuel.com/png/88/605/soviet-union-logo-png-clip-art.png'),
      CriteriaTag("Anarchism", 'https://w0.pngwave.com/png/92/423/anarchism-anarchy-symbol-anarchy-png-clip-art.png'),
      CriteriaTag("Pastafarianism", 'https://upload.wikimedia.org/wikipedia/commons/1/1d/Eucalyp-Deus_Pastafarianism.png'),
    ];

    return Column(
      children: <Widget>[
        Text(title, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
        ),
        ChipsInput(
          initialValue: userItemList == null
              ? <List<String>> []
              : userItemList
              .map((String ideology) => CriteriaTag(ideology, "https://f0.pngfuel.com/png/88/605/soviet-union-logo-png-clip-art.png"))
              .toList(),
          keyboardAppearance: Brightness.dark,
          textCapitalization: TextCapitalization.words,
          enabled: true,
          maxChips: 5,
          textStyle: TextStyle(height: 1.5, fontFamily: "Roboto", fontSize: 16),
          decoration: InputDecoration(
            fillColor: Color.fromRGBO(250, 150, 150, 1),
            border: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
          findSuggestions: (String query) {
            print("Query: '$query'");
            if (query.length > 0) {
              var lowercaseQuery = query.toLowerCase();
              var unSortedResults =
                  ideologiesCriteriaTagsMockData.where((profile) {
                    return profile.name
                        .toLowerCase()
                        .contains(lowercaseQuery);
                  }).toList(growable: false) +
                      [
                        CriteriaTag(query,
                            'https://f0.pngfuel.com/png/88/605/soviet-union-logo-png-clip-art.png')
                      ];
              return unSortedResults
                ..sort((a, b) => a.name
                    .toLowerCase()
                    .indexOf(lowercaseQuery)
                    .compareTo(b.name
                    .toLowerCase()
                    .indexOf(lowercaseQuery)));
            } else {
              return <CriteriaTag>[
                CriteriaTag("Communism",
                    'https://f0.pngfuel.com/png/88/605/soviet-union-logo-png-clip-art.png')
              ];
            }
            // return <AppProfile>[];
            //return mockResults;
          },
          onChanged: onChangedFunction,
          chipBuilder: (context, state, profile) {
            return InputChip(
              backgroundColor: Color.fromRGBO(250, 150, 150, 1),
              key: ObjectKey(profile),
              label: Text(profile.name),
              avatar: CircleAvatar(
                backgroundImage: NetworkImage(profile.imageUrl),
              ),
              onDeleted: () => state.deleteChip(profile),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            );
          },
          suggestionBuilder: (context, state, inputItem) {
            return ListTile(
              key: ObjectKey(inputItem),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(inputItem.imageUrl),
              ),
              title: Text(inputItem.name.toString().capitalize()),
              onTap: () => state.selectSuggestion(inputItem),
            );
          },
        ),
      ],
    )
    ;

  }
}
