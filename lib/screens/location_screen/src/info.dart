import 'package:flutter/material.dart';
import 'package:ricknmorty/data/models/location.dart';
import 'package:ricknmorty/data/models/character.dart';
import 'package:ricknmorty/theme/color_theme.dart';

class LocationInfo extends StatelessWidget {
  final Location location;

  LocationInfo(this.location);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            location.name,
            style: Theme.of(context).textTheme.headline5,
          ),
          Text(
            "Мир · ${location.measurements}",
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(
            location.about,
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
