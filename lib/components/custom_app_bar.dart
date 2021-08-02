import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ricknmorty/components/custom_circle_button.dart';
import 'package:ricknmorty/resources/main_icons.dart';
import 'package:ricknmorty/theme/color_theme.dart';

class CustomAppBar extends PreferredSize {
  final String title;
  final bool noBack;

  CustomAppBar({
    this.title,
    this.noBack = false,
  });

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    double appBarHeight = AppBar().preferredSize.height;
    return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leadingWidth: appBarHeight + 16,
        leading: noBack
            ? null
            : Container(
                margin: EdgeInsets.only(left: 16),
                child: CustomCircleButton(
                  onTap: () => Navigator.of(context).pop(),
                  bg: Theme.of(context).scaffoldBackgroundColor,
                  icon: SvgPicture.asset(
                    MainIcons.back,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
        centerTitle: false,
        title: title == null ? null : Text(title));
  }
}
