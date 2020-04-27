import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/User/user.dart';
import 'dart:math';
import 'package:school_app/extensions/extensions.dart';
import 'package:school_app/components/profileBox.dart';
import 'package:school_app/services/firestore_database.dart';

class ProfileSettingsPage extends StatefulWidget {
  @override
  _ProfileSettingsPageState createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _ageController = new TextEditingController();
  final TextEditingController _descriptionController = new TextEditingController();
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _employerController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    //_ageController.addListener(
    //    updateProfileInformation(
    //        {"age":_ageController.text},
    //        "680z5ai3TkU31oADJkIy5oSD0AB2"
    //    )
    //);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _nameController.dispose();
    _ageController.dispose();
    _descriptionController.dispose();
    _titleController.dispose();
    _employerController.dispose();
    super.dispose();
  }

  updateProfileInformation(String userId, Map<String, dynamic> data, ) async {
    await DatabaseService(userId: userId).updateUserData(data);
    print("updated $data");
  }
  updateProfileInformation2(String userId, Map<String, dynamic> data, TextEditingController tx) async {
    await DatabaseService(userId: userId).updateUserData(data);
    tx.notifyListeners();
    print("updated $data");
  }
  @override
  Widget build(BuildContext context) {
    User _user = Provider.of<User>(context);
    //DatabaseService _databaseUser = Provider.of<DatabaseService>(context);

    _nameController.text = _user.name;
    _ageController.text = _user.age.toString();
    _descriptionController.text = _user.description;
    _titleController.text = _user.title;
    _employerController.text = _user.employer;



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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "Personal details",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 10,
                    child: Column(
                      children: <Widget>[
                        new TextField(
                          controller: _nameController,
                          onSubmitted: (value) {
                            updateProfileInformation2(_user.userId, {"name": value.toString()},_nameController);
                            _user.setFirstName = value;
                            },
                          decoration: const InputDecoration(
                            hintText: "Name",
                            contentPadding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(fontSize: 20),
                        ),
                        new TextField(
                          controller: _ageController,
                          onSubmitted: (value) {
                            updateProfileInformation(_user.userId, {"age": int.parse(value)});
                            _user.setAge = int.parse(value);
                        },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "Age",
                            contentPadding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(fontSize: 20),
                        ),
                        new TextField(
                          controller: _employerController,
                          onSubmitted: (value) {
                            updateProfileInformation(_user.userId, {"employer": value});
                            _user.setEmployer = value;
                          },
                          decoration: const InputDecoration(
                            hintText: "Employer",
                            contentPadding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(fontSize: 20),
                        ),
                        new TextField(
                          controller: _titleController,
                          onSubmitted: (value) {
                            updateProfileInformation(_user.userId, {"title": value});
                            _user.setTitle = value;
                          },
                          decoration: const InputDecoration(
                            hintText: "Title",
                            contentPadding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Bio",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 10,
                    child: Column(
                      children: <Widget>[
                        new TextField(
                          controller: _descriptionController,
                          onSubmitted: (value) {
                            updateProfileInformation(_user.userId, {"description": value});
                            _user.setDescription = value;
                          },
                          decoration: const InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
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
