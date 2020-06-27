import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:school_app/components/profileBox.dart';
import 'package:school_app/User/user.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User _user = Provider.of<User>(context, listen: true);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: false,
            floating: false,
            delegate: _SliverAppBarDelegate(),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 10,
              ),
              ProfileBox(),
            ]),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Container(
                  child: FutureBuilder<Image>(
                    future: Future.value(_user.profilePicture),
                    builder:
                        (BuildContext context, AsyncSnapshot<Image> snapshot) {
                      if ([
                        ConnectionState.waiting,
                        ConnectionState.active,
                        ConnectionState.none,
                      ].contains(snapshot.connectionState)) {
                        return CircleAvatar(
                            child: new Text(_user.getFirstLetterOfName()));
                      } else if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          print("has error:" + snapshot.error.toString());
                          return Image.asset("assets/images/harvard.jpg");
                        } else
                          return _user.profilePicture;
                      } else return Text(_user.getFirstLetterOfName());
                    },
                  ),
                  //color: _randomColor(index),
                  height: 200.0);
            }),
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
            child: ChangeNotifierProvider<User>(
              create: (_) => User(),
              child: Consumer(
                builder: (context, User _user, _) => Image(
                  //image: AssetImage("/Users/donnyh/code/school_app/assets/images/mockProfileImage.jpeg"),
                  image: _user.profilePicture != null
                      ? _user.profilePicture //NetworkImage(_user.profileUrl)
                      : AssetImage(
                          "/Users/donnyh/code/school_app/assets/images/mockProfileImage.jpeg"),
                  fit: BoxFit.fitWidth,
                ),
              ),
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
