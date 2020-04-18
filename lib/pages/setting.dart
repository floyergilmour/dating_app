import 'package:flutter/material.dart';
import 'package:school_app/User/userState.dart';
import 'package:provider/provider.dart';

class Setting extends StatelessWidget {
  bool _isSelectedPushNotification = true;
  bool _isSelectedHideMyProfile = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(8, 70, 8, 10),
        child: Column(
          children: <Widget>[
            Text("Settings", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),),
            SizedBox(height: 40,),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 10,
              child: ListTile(
                onTap: () {
                  //Navigator.of(context).push(_createRoute());

                  },
                leading: CircleAvatar(
                  backgroundImage: AssetImage(
                      "/Users/donnyh/code/school_app/assets/images/mockProfileImage.jpeg"),
                ),
                title: Text("Donny Ho"),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 10,
              child: Column(
                children: <Widget>[
                  Column(
                    children: [
                      ListTile(
                        onTap: (){},
                        leading: Icon(Icons.lock),
                        title: Text("Change Password"),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                      _buildDivider(1),
                      ListTile(
                        leading: Icon(Icons.translate),
                        title: Text("Change Language (coming soon)"),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                      _buildDivider(1),
                      ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text("Change Location (coming soon)"),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Text("Other Settings", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),),
            SwitchListTile(
              activeColor: Color.fromRGBO(250, 128, 128, 1),
              contentPadding: EdgeInsets.all(0),
              value: _isSelectedPushNotification,
              title: Text("Push notifications"),
              onChanged: (value){},
            ),
            SwitchListTile(
              activeColor: Color.fromRGBO(250, 128, 128, 1),
              contentPadding: EdgeInsets.all(0),
              value: _isSelectedHideMyProfile,
              title: Text("Hide my profile"),
              onChanged: (value){},
            ),
          ],
        ),
      ),
    );
  }

  Container _buildDivider(double height) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      width: double.infinity,
      height: height,
      color: Colors.grey.shade400,
    );
  }



}
