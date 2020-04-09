import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  MainAppBar({
    Key key,
    @required this.appBarTitle,
    @required this.appBarHeight,
    @required this.imageUrl
  }
  ) : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  final Size preferredSize; // default is 56.0
  final String appBarTitle;
  final double appBarHeight;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(appBarTitle),
      actions: <Widget>[
        Container(
            width: appBarHeight,
            height: appBarHeight,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(imageUrl),
                )
            )
        ),
      ],
    );
  }

}