import 'package:flutter/material.dart';
import 'package:ricknmorty/data/dummy.dart';
import 'package:ricknmorty/data/models/character.dart';
import 'package:ricknmorty/theme/color_theme.dart';

class CharacterGridItem extends StatelessWidget {
  CharacterGridItem(this.character);
  final Character character;

  Widget CharacterStatus() {
    switch (character.status) {
      case 0:
        return const Text('ЖИВОЙ', style: TextStyle(color: AppColors.green, fontSize: 10));
        break;
      case 1:
        return const Text('МЁРТВЫЙ', style: TextStyle(color: AppColors.red, fontSize: 10));
        break;
      default:
        return const Text('НЕИЗВЕСТНО', style: TextStyle(color: AppColors.blue, fontSize: 10));
    }
  }

  String CharacterGender() {
    switch (character.gender) {
      case 0:
        return 'Мужской';
        break;
      case 1:
        return 'Женский';
        break;
      default:
        return 'Бесполый';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/character', arguments: {'id': character.id}),
        child: Column(
          children: [
            Expanded(
              child: FittedBox(
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(character.imageName),
                ),
              ),
            ),
            SizedBox(height: 18),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CharacterStatus(),
                Text(
                  character.fullName,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Text(
                  "${character.race}, ${CharacterGender()}",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
