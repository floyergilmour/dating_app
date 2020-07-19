import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/User/user.dart';
import 'package:school_app/components/custom_raised_button.dart';
import 'package:school_app/components/chipsInput.dart';
import 'package:school_app/components/custom_input_card.dart';
import 'package:school_app/components/custom_text_field.dart';
import 'package:school_app/components/image_capture.dart';
import 'package:school_app/services/auth.dart';
import 'dart:math';
import 'package:school_app/services/firestore_database.dart';


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
    User _user = Provider.of<User>(context);
    String _name = _user.name;
    int _age = _user.age;
    String _employer = _user.employer;
    String _title = _user.title;
    String _description = _user.description;
    List<dynamic> _ideologies = _user.ideologies == null ? [] : _user.ideologies;
    List<dynamic> _religions = _user.religions == null ? [] : _user.religions;
    List<dynamic> _interests = _user.interests == null ? [] : _user.interests;

    _nameController.text = _name;
    _ageController.text = _age.toString();
    _employerController.text = _employer;
    _titleController.text = _title;
    _descriptionController.text = _description;

    _updateProfileInformation() async {
      var userId = _user.userId;

      _user.setName = _name;
      _user.setAge = _age.toInt();
      _user.setEmployer = _employer;
      _user.setTitle = _title;
      _user.setDescription = _description;
      _user.setIdeologies = _ideologies;
      _user.setReligions = _religions;
      _user.setInterests = _interests;

      Map<String, dynamic> data = {
        "name": _name,
        "age": _age,
        "employer": _employer,
        "title": _title,
        "description": _description,
        "ideologies": _ideologies,
        "religions": _religions,
        "interests": _interests,
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
                    SizedBox(height: 10,),
                    Text("Personal details", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),),
                    SizedBox(height: 10,),
                CustomInputCard(textFields: [
                  CustomTextField(hint: "Name", controller: _nameController, onChanged: (data) {_name = data;}),
                  CustomTextField(hint: "Age", controller: _ageController, onChanged: (data) {_age = int.parse(data);}),
                  CustomTextField(hint: "Employer", controller: _employerController, onChanged: (data) {_employer = data;}),
                  CustomTextField(hint: "Title", controller: _titleController, onChanged: (data) {_title = data;}),
                ]),
                    SizedBox(height: 20,),
                    Text("Bio", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),),
                    SizedBox(height: 10,),
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
                                  child:
                                  CustomTextField(
                                      hint: "bio",
                                      controller: _descriptionController,
                                      onChanged: (value) {
                                        _description = value;
                                  }),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    ChipsInputBuilder(
                      title: "Ideologies",
                      userItemList: _user.ideologies,
                      onChangedFunction: (data) {
                        _user.setIdeologies = data.map((criteriaTag) => criteriaTag.name).cast<String>().toList();
                        },
                    ),
                    ChipsInputBuilder(
                      title: "Religions",
                      userItemList: _user.religions,
                      onChangedFunction: (data) {
                        _user.setReligions = data.map((criteriaTag) => criteriaTag.name).cast<String>().toList();
                      },
                    ),
                    ChipsInputBuilder(
                      title: "Interest",
                      userItemList: _user.interests,
                      onChangedFunction: (data) {
                        _user.setInterests = data.map((criteriaTag) => criteriaTag.name).cast<String>().toList();
                      },
                    ),
                    SizedBox(height: 40,),
                    Center(
                      child: CustomRaisedButton(buttonText: "Save changes",
                            onPressed:  () {
                              _updateProfileInformation();
                              Navigator.pop(context);
                              },
                          )
                    ),
                    SizedBox(height: 40,),
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