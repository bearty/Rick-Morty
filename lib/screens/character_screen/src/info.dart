import 'package:flutter/material.dart';
import 'package:ricknmorty/data/models/character.dart';
import 'package:ricknmorty/theme/color_theme.dart';

import 'info_item.dart';

class CharacterInfo extends StatelessWidget {
  final Character character;

  CharacterInfo(this.character);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(
            character.fullName,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorPalette.white,
              fontSize: 34,
            ),
          ),
          Text(
            character.status == 0 ? 'ЖИВОЙ' : 'МËРТВЫЙ',
            style: TextStyle(
              color: character.status == 0 ? ColorPalette.green : ColorPalette.red,
              fontSize: 10,
            ),
          ),
          SizedBox(height: 36),
          Text(
            //description
            character.about,
            style: TextStyle(
              color: ColorPalette.white,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InfoItem(
                  title: 'Пол',
                  subtitle: character.gender == 0 ? 'Мужской' : "Женский",
                ),
              ),
              Expanded(
                child: InfoItem(
                  title: 'Раса',
                  subtitle: character.race,
                ),
              ),
            ],
          ),
          InfoItem(
            title: 'Локация',
            subtitle: character.location,
            onTap: () => Navigator.pushNamed(context, '/location', arguments: {'id': character.locationId}),
          ),
          /*InfoItem(
            title: 'Местоположение',
            subtitle: "Земля (Измерение подменны)",
            onTap: () => print('go to place'),
          ),*/
        ],
      ),
    );
  }
}
