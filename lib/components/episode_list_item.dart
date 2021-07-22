import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:ricknmorty/data/dummy.dart';
import 'package:ricknmorty/data/models/episode.dart';
import 'package:ricknmorty/resources/main_icons.dart';
import 'package:ricknmorty/theme/color_theme.dart';

class EpisodeListItem extends StatelessWidget {
  EpisodeListItem(this.episode);

  final Episode episode;

  DateFormat dateformat = new DateFormat.yMMMMd('ru');
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/episode', arguments: {'id': episode.id}),
      behavior: HitTestBehavior.translucent, //fix tap empty place in child container
      child: Container(
        margin: EdgeInsets.only(bottom: 24),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(episode.imageName),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 18),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'СЕРИЯ ${episode.series}',
                    style: TextStyle(
                      color: ColorPalette.blue,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    episode.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: ColorPalette.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    dateformat.format(episode.premiere),
                    style: TextStyle(
                      color: ColorPalette.gray_text,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset(
              MainIcons.arrow,
              color: ColorPalette.gray_text,
            ),
          ],
        ),
      ),
    );
  }
}
