import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/User/user.dart';
import 'package:school_app/extensions/extensions.dart';

class ProfileBox extends StatefulWidget {
  @override
  _ProfileBoxState createState() => _ProfileBoxState();
}

class _ProfileBoxState extends State<ProfileBox> {
  @override
  Widget build(BuildContext context) {
    User _user = Provider.of<User>(context, listen: true);
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _profileBoxTitle(_user),
          Container(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _user.ideology.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildSimilarityBoxes(_user.ideology[index]);
              },
            ),
          ),
          SizedBox(height: 13,),
          Text(
            _user.description,
          ),
        ],
      ),
    );
  }

  Row _profileBoxTitle(User user) {
    return Row(
      children: [
        Text(
          user.firstName,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
        ),
        SizedBox(width: 10),
        Text(
          user.age.toString(),
          style: TextStyle(fontSize: 30),
        )
      ],
    );
  }

  Container _buildSimilarityBoxes(String element) {
    return Container(
      alignment: Alignment.center,
      decoration: new BoxDecoration(
          color: Color.fromRGBO(250, 128, 128, 1),
          borderRadius: new BorderRadius.all(Radius.circular(40.0)),
      ),
      padding: EdgeInsets.all(7),
      child: Text(element.capitalize(), style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
