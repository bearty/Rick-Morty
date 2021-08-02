import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ricknmorty/resources/main_icons.dart';
import 'package:ricknmorty/theme/color_theme.dart';

class ChooseFilterItem extends StatelessWidget {
  final String name;
  final bool selected;
  final Function onPress;

  ChooseFilterItem({
    @required this.name,
    @required this.selected,
    @required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      onTap: onPress,
      title: Text(
        name,
        style: TextStyle(
          color: selected ? AppColors.blue : Theme.of(context).accentColor,
          fontSize: 16,
        ),
      ),
    );
  }
}
