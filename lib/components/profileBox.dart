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
          SizedBox(height: 13,),
          Row(children: _buildTags(_user.ideologies, Color.fromRGBO(250, 128, 128, 0.8)),),
          SizedBox(height: 13,),
          Row(children: _buildTags(_user.religions, Color.fromRGBO(240, 246, 150, 0.8)),),
          SizedBox(height: 13,),
          Row(children: _buildTags(_user.interests, Color.fromRGBO(150, 247, 210, 0.8)),),
          SizedBox(height: 13,),
          Text(_user.description,),

        ],
      ),
    );
  }

  List<Row> _buildTags(List<String> tags, Color c){

    var tagsList = tags.map((element) =>
        Row(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              decoration: new BoxDecoration(
                color: c,
                borderRadius: new BorderRadius.all(Radius.circular(40.0)),
              ),
              padding: EdgeInsets.all(7),
              child: Text(element.capitalize(), style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            SizedBox(width: 3,)
          ],
        )
    ).toList();

    return tagsList;
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

}
