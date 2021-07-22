import 'package:flutter/material.dart';
import 'package:ricknmorty/data/dummy.dart';
import 'package:ricknmorty/data/models/character.dart';
import 'package:ricknmorty/theme/color_theme.dart';

class CharacterGridItem extends StatelessWidget {
  CharacterGridItem(this.character);
  final Character character;

  Widget CharacterStatus() {
    TextStyle style = TextStyle(color: character.status == 0 ? ColorPalette.green : ColorPalette.red, fontSize: 10);

    switch (character.status) {
      case 0:
        return const Text('ЖИВОЙ', style: TextStyle(color: ColorPalette.green, fontSize: 10));
        break;
      case 1:
        return const Text('МЁРТВЫЙ', style: TextStyle(color: ColorPalette.red, fontSize: 10));
        break;
      case 2:
        return const Text('НЕИЗВЕСТНО', style: TextStyle(color: ColorPalette.blue, fontSize: 10));
        break;
      default:
        return const Text('');
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
      case 2:
        return 'Бесполый';
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
                  style: TextStyle(
                    color: ColorPalette.white,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "${character.race}, ${CharacterGender()}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorPalette.gray_text,
                    fontSize: 12,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
