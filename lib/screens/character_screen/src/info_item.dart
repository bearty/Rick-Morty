import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ricknmorty/resources/main_icons.dart';
import 'package:ricknmorty/theme/color_theme.dart';

class InfoItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onTap;

  InfoItem({
    @required this.title,
    @required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      onTap: onTap,
      title: Text(
        title,
        style: TextStyle(
          color: ColorPalette.gray_text,
          fontSize: 12,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: ColorPalette.white,
          fontSize: 14,
        ),
      ),
      trailing: onTap == null
          ? const SizedBox()
          : SvgPicture.asset(
              MainIcons.arrow,
              color: ColorPalette.white,
            ),
    );
  }
}
