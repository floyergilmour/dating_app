import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/User/user.dart';
import 'dart:math';
import 'package:school_app/services/firestore_database.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';

class ProfileSettingsPage extends StatefulWidget {
  @override
  _ProfileSettingsPageState createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _ageController = new TextEditingController();
  final TextEditingController _descriptionController =
      new TextEditingController();
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _employerController = new TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _descriptionController.dispose();
    _titleController.dispose();
    _employerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const ideologiesCriteriaTagsMockData = <CriteriaTags>[
      CriteriaTags("Communism",
          'https://f0.pngfuel.com/png/88/605/soviet-union-logo-png-clip-art.png'),
      CriteriaTags("Anarchism",
          'https://w0.pngwave.com/png/92/423/anarchism-anarchy-symbol-anarchy-png-clip-art.png'),
      CriteriaTags("Pastafarianism",
          'https://upload.wikimedia.org/wikipedia/commons/1/1d/Eucalyp-Deus_Pastafarianism.png'),
    ];

    User _user = Provider.of<User>(context);
    String _name = _user.name;
    int _age = _user.age;
    String _employer = _user.employer;
    String _title = _user.title;
    String _description = _user.description;
    List<String> _ideologies;

    _nameController.text = _name;
    _ageController.text = _age.toString();
    _employerController.text = _employer;
    _titleController.text = _title;
    _descriptionController.text = _description;


    updateProfileInformation(String userId, Map<String, dynamic> data ) async {
      print("updated $data");
      await DatabaseService(userId: userId).updateUserData(data);
    }

    _updateProfileInformation() async {
      var userId = _user.userId;

      _user.setName = _name;
      _user.setAge = _age;
      _user.setEmployer = _employer;
      _user.setTitle = _title;
      _user.setDescription = _description;
      _user.setIdeologies = _ideologies;

      Map<String, dynamic> data = {
        "name": _name,
        "age": _user.age,
        "employer": _user.employer,
        "title": _user.title,
        "description": _user.description,
        "ideologies": _user.ideologies,
      };
      print("updated $data");
      await DatabaseService(userId: userId).updateUserData(data);
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: false,
            floating: false,
            delegate: _SliverAppBarDelegate(),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Personal details",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                      child: Column(
                        children: <Widget>[
                          new TextField(
                            controller: _nameController,
                            onChanged: (value) {
                                _name = value;
                              print(value);
                            },
                            decoration: const InputDecoration(
                              hintText: "Name",
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 5, 5, 5),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(fontSize: 20),
                          ),
                          new TextField(
                            controller: _ageController,
                            onChanged: (value) {
                              _age = int.parse(value);
                              print(value);
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: "Age",
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 5, 5, 5),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(fontSize: 20),
                          ),
                          new TextField(
                            controller: _employerController,
                            onChanged: (value) {
                              _employer = value;
                              print(value);
                            },
                            decoration: const InputDecoration(
                              hintText: "Employer",
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 5, 5, 5),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(fontSize: 20),
                          ),
                          new TextField(
                            controller: _titleController,
                            onChanged: (value) {
                              _title = value;
                              print(value);
                            },
                            decoration: const InputDecoration(
                              hintText: "Title",
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 5, 5, 5),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Bio",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: new ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: 300.0,
                              ),
                              child: new Scrollbar(
                                child: new SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  reverse: true,
                                  child: new TextField(
                                    //maxLines: null,
                                    controller: _descriptionController,
                                    onChanged: (value) {
                                      _description = value;
                                      print(value);
                                    },
                                    decoration: const InputDecoration(
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          10, 5, 5, 5),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Ideologies",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                    ),
                    ChipsInput(
                      //initialValue: [CriteriaTags("Communism", 'https://f0.pngfuel.com/png/88/605/soviet-union-logo-png-clip-art.png')],
                      initialValue: _user.ideologies == null
                          ? []
                          : _user.ideologies
                              .map((String ideology) => CriteriaTags(ideology,
                                  "https://f0.pngfuel.com/png/88/605/soviet-union-logo-png-clip-art.png"))
                              .toList(),
                      keyboardAppearance: Brightness.dark,
                      textCapitalization: TextCapitalization.words,
                      enabled: true,
                      maxChips: 5,
                      textStyle: TextStyle(
                          height: 1.5, fontFamily: "Roboto", fontSize: 16),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        // prefixIcon: Icon(Icons.search),
                        // hintText: formControl.hint,
                        //labelText: "Select Ideologies",
                        // enabled: false,
                        // errorText: field.errorText,
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
                                    CriteriaTags("Communism",
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
                          return <CriteriaTags>[
                            CriteriaTags("Communism",
                                'https://f0.pngfuel.com/png/88/605/soviet-union-logo-png-clip-art.png')
                          ];
                        }
                        // return <AppProfile>[];
                        //return mockResults;
                      },
                      onChanged: (data) {
                        print("onChanged ideologies");
                        print(data);
                        _ideologies = data.map((e) => e.name.toString()).toList();
                        print(_ideologies);
                      },
                      chipBuilder: (context, state, profile) {
                        return InputChip(
                          key: ObjectKey(profile),
                          label: Text(profile.name),
                          avatar: CircleAvatar(
                            backgroundImage: NetworkImage(profile.imageUrl),
                          ),
                          onDeleted: () => state.deleteChip(profile),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        );
                      },
                      suggestionBuilder: (context, state, inputItem) {
                        return ListTile(
                          key: ObjectKey(inputItem),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(inputItem.imageUrl),
                          ),
                          title: Text(inputItem.name),
                          onTap: () => state.selectSuggestion(inputItem),
                        );
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Builder(
                        builder: (context) => ButtonTheme(
                          height: 50,
                          minWidth: 150,
                          child: RaisedButton(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            onPressed: () {
                              _updateProfileInformation();
                              print("Saving data");
                            },
                            color: Color.fromRGBO(150, 247, 210, 1),
                            textColor: Colors.white,
                            child: Text(
                              "Save changes",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  double scrollAnimationValue(double shrinkOffset) {
    double maxScrollAllowed = maxExtent - minExtent;
    return ((maxScrollAllowed - shrinkOffset) / maxScrollAllowed)
        .clamp(0, 1)
        .toDouble();
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double visibleMainHeight = max(maxExtent - shrinkOffset, minExtent);
    final double animationVal = scrollAnimationValue(shrinkOffset);
    return Container(
      height: visibleMainHeight,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Opacity(
            opacity: animationVal,
            child: Image(
              image: AssetImage(
                  "/Users/donnyh/code/school_app/assets/images/mockProfileImage.jpeg"),
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    flex: (animationVal * 100).toInt(),
                    child: Container(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => 300.0;

  @override
  double get minExtent => 56.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class CriteriaTags {
  final String _name;
  final String _imageUrl;

  const CriteriaTags(this._name, this._imageUrl);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is CriteriaTags && name == other.name;

  @override
  int get hashCode => name.hashCode;

  String get name => _name;

  String get imageUrl => _imageUrl;

  @override
  String toString() {
    return name;
  }
}
