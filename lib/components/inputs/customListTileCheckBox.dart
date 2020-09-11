import 'package:flutter/material.dart';
import 'package:Nuvle/styles/colors.dart';

class CustomListTileCheckBox extends StatelessWidget {
  final String text;
  final bool value;
  final void Function(bool) onChanged;

  const CustomListTileCheckBox({Key key, @required this.text, @required this.onChanged, @required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onChanged != null
          ? () {
              onChanged(!value);
            }
          : null,
      leading: Text(
        text,
        style: TextStyle(fontSize: 16, letterSpacing: 0.3),
      ),
      trailing: Container(
        margin: EdgeInsets.only(right: 14),
        height: 24,
        width: 24,
        child: Checkbox(
          checkColor: CustomColors.primary100,
          activeColor: Colors.transparent,
          value: value,
          onChanged: onChanged,
        ),
        decoration: BoxDecoration(
          color: Color(0xff575560),
          border: Border.all(color: CustomColors.primary, width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
