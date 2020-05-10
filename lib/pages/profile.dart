import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:school_app/components/profileBox.dart';

class Profile extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: false,
            floating: false,
            delegate: _SliverAppBarDelegate(),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
                [
                  SizedBox(
                    height: 10,
                  ),
                  ProfileBox(),
                ]
            ),
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
            child: Image(
              image: AssetImage("/Users/donnyh/code/school_app/assets/images/mockProfileImage.jpeg"),
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
