import 'package:flutter/material.dart';
import 'package:school_app/User/user.dart';
import 'package:provider/provider.dart';
import 'package:school_app/components/buildDivider.dart';
import 'package:school_app/components/image_capture.dart';
import 'package:school_app/pages/profileSettingsPage.dart';
import 'package:school_app/pages/settings/ChangePasswordPage.dart';

class Setting extends StatelessWidget {
  final bool _isSelectedPushNotification = true;
  final bool _isSelectedHideMyProfile = true;

  @override
  Widget build(BuildContext context) {
    User _user = Provider.of<User>(context, listen: true);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(8, 70, 8, 10),
        child: Column(
          children: <Widget>[
            Text(
              "Settings",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 40,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 10,
              child: ListTile(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider<User>.value(
                        value: _user,
                        child: Scaffold(
                          appBar: AppBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            title: Text(_user.name + '\'s profile'),
                          ),
                          body: ProfileSettingsPage(),
                        )),
                  ),
                ),
                leading: FutureBuilder(
                  future: Future.value(_user.profilePicture),
                  builder: (BuildContext context,
                      AsyncSnapshot<Image> snapshot) {
                    if ([ConnectionState.waiting, ConnectionState.active, ConnectionState.none]
                        .contains(snapshot.connectionState)) {
                      return CircleAvatar(
                          child: new Text(_user.getFirstLetterOfName()));
                    } else {
                      if (snapshot.hasError)
                        return CircleAvatar(
                            child: new Text(_user.getFirstLetterOfName()));
                      else
                        return CircleAvatar(
                          backgroundImage: _user.profilePictureNetwork,
                        );
                    }
                  },
                ),
                title: Text(_user.name),
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
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ChangeNotifierProvider<User>.value(
                                    value: _user,
                                    child: Scaffold(
                                      appBar: AppBar(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        title: Text("Change password"),
                                      ),
                                      body: ChangePasswordPage(),
                                    )),
                          ),
                        ),
                        leading: Icon(Icons.lock),
                        title: Text("Change Password"),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                      BuildDivider(),
                      ListTile(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ChangeNotifierProvider<User>.value(
                                    value: _user,
                                    child: Scaffold(
                                      appBar: AppBar(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        title: Text("Profile Picture"),
                                      ),
                                      body: ImageCapture(userId: _user.userId),
                                    )),
                          ),
                        ),
                        leading: Icon(Icons.picture_in_picture),
                        title: Text("Change Profile Picture"),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                      BuildDivider(),
                      ListTile(
                        leading: Icon(Icons.translate),
                        title: Text("Change Language (coming soon)"),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                      BuildDivider(),
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
            const SizedBox(
              height: 40,
            ),
            Text(
              "Other Settings",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
            ),
            SwitchListTile(
              activeColor: Color.fromRGBO(250, 128, 128, 1),
              contentPadding: EdgeInsets.all(0),
              value: _isSelectedPushNotification,
              title: Text("Push notifications"),
              onChanged: (value) {},
            ),
            SwitchListTile(
              activeColor: Color.fromRGBO(250, 128, 128, 1),
              contentPadding: EdgeInsets.all(0),
              value: _isSelectedHideMyProfile,
              title: Text("Hide my profile"),
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}
