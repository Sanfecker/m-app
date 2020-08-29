import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CardLazyLoading extends StatelessWidget {
  final int count;
  final bool enableScrolling;
  CardLazyLoading({this.count = 2, this.enableScrolling = true});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(vertical: 10),
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          Shimmer.fromColors(
            baseColor: Theme.of(context).dialogBackgroundColor,
            highlightColor: Colors.grey[100],
            child: Row(
              children: List.generate(
                count,
                (i) => Container(
                  margin: EdgeInsets.only(right: 12),
                  width: 165,
                  height: 220,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        height: 100,
                        width: 165,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              color: Colors.white,
                              height: 15,
                              width: screenSize.width * 0.40,
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              color: Colors.white,
                              height: 15,
                              width: screenSize.width * 0.20,
                            ),
                          ],
                        ),
                      ),
                    ],
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
