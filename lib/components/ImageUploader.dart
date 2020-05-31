import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/User/user.dart';

class ImageUploader extends StatefulWidget {
  final File file;

  ImageUploader({
    Key key,
    this.file,
  }) : super(key: key);

  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {

  final FirebaseStorage _storage = FirebaseStorage(
      storageBucket: "gs://school-app-dff02.appspot.com");
  StorageUploadTask _uploadTask;

  @override
  Widget build(BuildContext context) {
    User _user = Provider.of<User>(context, listen: true);

    void startUpload() {
      String fileName = "${_user.userId}/profile_picture.png";
      StorageReference fileReference =_storage.ref().child(fileName);

      setState(() {
        _uploadTask = fileReference.putFile(widget.file);
      });
      _user.getProfilePicture();
    }

    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
        stream: _uploadTask.events,
        builder: (context, snapshot) {
          var event = snapshot?.data?.snapshot;

          double progressPercent = event != null
              ? event.bytesTransferred / event.totalByteCount
              : 0;

          return Column(
            children: <Widget>[
              if (_uploadTask.isComplete)
                Text("Upload finished"),

              if (_uploadTask.isPaused)
                FlatButton(
                  child: Icon(Icons.play_arrow),
                  onPressed: _uploadTask.resume,
                ),
              if (_uploadTask.isInProgress)
                FlatButton(
                  child: Icon(Icons.pause),
                  onPressed: _uploadTask.pause,
                ),

              LinearProgressIndicator(value: progressPercent,),
              Text('${(progressPercent * 100).toStringAsFixed(2)} %')
            ],
          );
        },
      );
    } else {
      return FlatButton.icon(onPressed:() {
        startUpload();
      },
          icon: Icon(Icons.cloud_upload),
          label: Text("Upload profile picture"));
    }
  }
}
