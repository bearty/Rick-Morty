import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ricknmorty/components/custom_circle_button.dart';
import 'package:ricknmorty/resources/main_icons.dart';
import 'package:ricknmorty/theme/color_theme.dart';

class FilterAppBar extends PreferredSize {
  final String title;
  final Widget right;

  FilterAppBar({
    this.title,
    this.right,
  });

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    double appBarHeight = AppBar().preferredSize.height;
    return AppBar(
      backgroundColor: Theme.of(context).dividerColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      leadingWidth: appBarHeight + 16,
      leading: IconButton(
        onPressed: () => Navigator.of(context).maybePop(),
        icon: SvgPicture.asset(
          MainIcons.back,
          color: Theme.of(context).accentColor,
        ),
      ),
      centerTitle: false,
      title: title == null ? null : Text(title),
      actions: [right != null ? right : const SizedBox()],
    );
  }
}
