import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:school_app/User/user.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context);
    print(DateTime.now().toString() + ": profile.dart: user.status : " + user.status.toString());
    print(DateTime.now().toString() + ": profile.dart: user.loggedInUser : " + user.loggedInUser.firstName.toString());
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(),
          ),
          SliverFillRemaining(
            child: cell("Name",user.loggedInUser.getFullName() ),
          )
        ],
      ),
    );
  }
}

Column cell(String titel, String content){
  Text _title = Text(titel.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),);
  Text _content = Text(titel, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),);
  Column result = Column(children: [_title, _content],);
  return result;
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
    UserState userState = Provider.of<UserState>(context, listen: true);
    final double visibleMainHeight = max(maxExtent - shrinkOffset, minExtent);
    final double animationVal = scrollAnimationValue(shrinkOffset);
    return Container(
      height: visibleMainHeight,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(color: Colors.blue),
          Opacity(
              opacity: animationVal,
              child: Image.network(
                "https://picsum.photos/500/500",
                fit: BoxFit.cover,
              )),
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
                  Column(
                    children: <Widget>[
                      Text(' Profile',
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                              color: Colors.white)),
                      SizedBox(
                        height: 30,
                      ),
                      CircleAvatar(
                        radius: 45.0,
                        backgroundColor: Colors.redAccent,
                        child: Text('DH',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                  Expanded(
                    flex: 100,
                    child: Container(),
                  )
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
