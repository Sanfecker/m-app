import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListLazyLoading extends StatelessWidget {
  final int count;
  final EdgeInsetsGeometry padding;
  final bool enableScrolling;
  final double height;
  ListLazyLoading(
      {this.count = 2,
      this.padding,
      this.height = 220,
      this.enableScrolling = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ListView(
        shrinkWrap: true,
        physics: enableScrolling
            ? BouncingScrollPhysics()
            : NeverScrollableScrollPhysics(),
        padding: padding,
        children: <Widget>[
          Shimmer.fromColors(
            baseColor: Theme.of(context).dialogBackgroundColor,
            highlightColor: Colors.grey[100],
            child: Column(
              children: List.generate(
                count,
                (i) => Container(
                  margin: EdgeInsets.only(bottom: 20),
                  height: height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
