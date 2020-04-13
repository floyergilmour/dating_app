import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_app/User/user.dart';
import 'dart:math';
import 'package:school_app/extensions/extensions.dart';
import 'package:provider/provider.dart';
import 'package:school_app/components/profileBox.dart';
class Profile extends StatelessWidget {
  Color _randomColor(int index) {
    if (index % 3 == 0) {
      return Colors.pink;
    } else if (index % 3 == 1) {
      return Colors.blueAccent;
    }

    return Colors.amber;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
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
                  child: Image(
                    image: AssetImage(
                        "/Users/donnyh/code/school_app/assets/images/mockProfileImage.jpeg"),
                    fit: BoxFit.fitHeight,
                  ),
                  color: _randomColor(index),
                  height: 200.0);
            }),
          ),
        ],
      ),
    );
  }
}

Row cell(String titel, String content) {
  Text _title = Text(
    titel.capitalize(),
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
  );
  Text _content = Text(
    content,
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
  );
  Row result = Row(
    children: [_title, _content],
  );
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
    final double visibleMainHeight = max(maxExtent - shrinkOffset, minExtent);
    final double animationVal = scrollAnimationValue(shrinkOffset);
    return Container(
      height: visibleMainHeight,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(color: Color.fromRGBO(250, 128, 128, 1)),
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
                  Column(
                    children: <Widget>[
                      /* Text('${_user.firstName}\'s Profile',
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                              color: Colors.white)),

                      */
                      SizedBox(
                        height: 30,
                      ),
                      //CircleAvatar(
                      //  radius: 90.0,
                      //  backgroundImage: AssetImage("/Users/donnyh/code/school_app/assets/images/mockProfileImage.jpeg"),
                      //  backgroundColor: Colors.transparent,
                      //),
                      SizedBox(
                        height: 50,
                      ),
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
