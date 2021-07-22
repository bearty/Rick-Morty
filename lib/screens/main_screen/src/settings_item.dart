import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final String name;
  final Widget leading;
  final String title;
  final String subtitle;
  final Widget trailing;
  final Function onTap;
  final bool bottomDivider;
  const SettingsItem({
    Key key,
    this.name,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.bottomDivider = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 36),
        Text(name.toUpperCase(), style: Theme.of(context).textTheme.subtitle2),
        const SizedBox(height: 24),
        ListTile(
          onTap: onTap,
          leading: leading,
          contentPadding: const EdgeInsets.all(0),
          title: Text(
            title,
            style: TextStyle(
                color: Theme.of(context).textTheme.headline6.color,
                fontSize: onTap == null ? 13 : 16),
          ),
          subtitle: subtitle == null
              ? null
              : Text(
                  subtitle,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
          trailing: trailing,
        ),
        const SizedBox(height: 36),
        !bottomDivider
            ? const SizedBox()
            : Divider(
                color: Theme.of(context).accentColor,
                height: 2,
              ),
      ],
    );
  }
}
