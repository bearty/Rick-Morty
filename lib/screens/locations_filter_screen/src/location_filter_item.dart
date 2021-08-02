import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ricknmorty/resources/main_icons.dart';
import 'package:ricknmorty/theme/color_theme.dart';

class LocationFilterItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onPress;

  LocationFilterItem({
    @required this.title,
    @required this.subtitle,
    @required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      onTap: onPress,
      trailing: SvgPicture.asset(
        MainIcons.arrow,
      ),
      title: Container(
        // color: Colors.red,
        child: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 16,
          ),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: AppColors.gray,
          fontSize: 14,
        ),
      ),
    );
  }
}
