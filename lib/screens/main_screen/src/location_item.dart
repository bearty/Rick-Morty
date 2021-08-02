import 'package:flutter/material.dart';
import 'package:ricknmorty/data/dummy.dart';
import 'package:ricknmorty/data/models/location.dart';
import 'package:ricknmorty/theme/color_theme.dart';

class LocationItem extends StatelessWidget {
  final Location location;
  const LocationItem(this.location);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/location', arguments: {'id': location.id}),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                image: location.imageName.isEmpty
                    ? null
                    : DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(location.imageName),
                      ),
              ),
            ),
            ListTile(
              tileColor: Theme.of(context).dialogBackgroundColor,
              title: Text(
                location.name,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).accentColor,
                ),
              ),
              subtitle: Text(
                "Мир · ${location.measurements}",
                style: TextStyle(
                  color: AppColors.gray,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
