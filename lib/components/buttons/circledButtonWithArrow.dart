import 'package:flutter/material.dart';
import 'package:Nuvle/styles/colors.dart';
import 'package:Nuvle/styles/nuvleIcons.dart';

class CircledButtonWithArrow extends StatelessWidget {
  final void Function() onPressed;

  const CircledButtonWithArrow({Key key, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      child: RawMaterialButton(
        onPressed: onPressed,
        shape: CircleBorder(),
        fillColor: CustomColors.primary100,
        splashColor: CustomColors.primary900,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              bottom: 0,
              left: -2,
              child: Icon(
                NuvleIcons.icon_right,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
