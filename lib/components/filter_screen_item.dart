import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ricknmorty/resources/main_icons.dart';
import 'package:ricknmorty/theme/color_theme.dart';

class FilterItem extends StatelessWidget {
  final String title;
  final Widget subtitle;

  FilterItem({
    @required this.title,
    @required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      title: Container(
        // color: Colors.red,
        child: Text(
          title.toUpperCase(),
          style: TextStyle(
            color: AppColors.gray,
            fontSize: 10,
            letterSpacing: 1.5,
          ),
        ),
      ),
      subtitle: Container(
        margin: EdgeInsets.only(top: 24),
        // color: Colors.red,
        child: subtitle,
      ),
    );
  }
}
