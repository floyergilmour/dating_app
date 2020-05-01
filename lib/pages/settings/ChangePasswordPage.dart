import 'package:flutter/material.dart';

class ChangePasswordPage extends StatelessWidget {

  Widget _buildPasswordCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 300.0,
        ),
        child: new TextField(
          obscureText: true,
          onChanged: (value) {
            print(value);
          },
          decoration: const InputDecoration(
            hintText: "Existing password",
            contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            border: InputBorder.none,
          ),
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 300.0,
              ),
              child: new TextField(
                obscureText: true,
                //maxLines: null,
                //controller: _descriptionController,
                onChanged: (value) {
                  //_description = value;
                  print(value);
                },
                decoration: const InputDecoration(
                  hintText: "Existing password",
                  contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 300.0,
              ),
              child: new TextField(
                obscureText: true,
                //maxLines: null,
                //controller: _descriptionController,
                onChanged: (value) {
                  //_description = value;
                  print(value);
                },
                decoration: const InputDecoration(
                  hintText: "New password",
                  contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 300.0,
              ),
              child: new TextField(
                obscureText: true,
                //maxLines: null,
                //controller: _descriptionController,
                onChanged: (value) {
                  //_description = value;
                  print(value);
                },
                decoration: const InputDecoration(
                  hintText: "Repeat new password",
                  contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          SizedBox(height: 100,),
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
                    //_updateProfileInformation();
                    print("Saving Password");
                    Navigator.pop(context);
                  },
                  color: Color.fromRGBO(250, 150, 150, 1),//Color.fromRGBO(150, 247, 210, 1),
                  textColor: Colors.white,
                  child: Text(
                    "Save changes",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
