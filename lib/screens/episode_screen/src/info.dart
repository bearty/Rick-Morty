import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ricknmorty/data/models/episode.dart';
import 'package:ricknmorty/data/models/character.dart';
import 'package:ricknmorty/theme/color_theme.dart';

import 'info_item.dart';

class EpisodeInfo extends StatelessWidget {
  final Episode episode;

  EpisodeInfo(this.episode);

  @override
  Widget build(BuildContext context) {
    DateFormat dateformat = new DateFormat.yMMMMd('ru');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(
            episode.name,
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          Text(
            "СЕРИЯ ${episode.series}",
            style: TextStyle(
              color: AppColors.blue,
              fontSize: 10,
            ),
          ),
          SizedBox(height: 36),
          Text(
            episode.plot,
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          InfoItem(
            title: 'Премьера',
            subtitle: dateformat.format(episode.premiere),
          ),
        ],
      ),
    );
  }
}
