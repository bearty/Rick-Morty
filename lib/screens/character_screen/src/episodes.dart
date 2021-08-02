import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ricknmorty/components/episode_list_item.dart';
import 'package:ricknmorty/data/models/episode.dart';
import 'package:ricknmorty/theme/color_theme.dart';

class CharacterEpisodes extends StatelessWidget {
  final List<Episode> episodes;

  CharacterEpisodes(this.episodes);

  @override
  Widget build(BuildContext context) {
    if (episodes.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Эпизоды',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 20,
                ),
              ),
              TextButton(
                onPressed: () => print("All episodes"),
                child: Text(
                  'Все эпизоды',
                  style: TextStyle(
                    color: AppColors.gray,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 24.0),
              itemCount: episodes.length > 6 ? 6 : episodes.length,
              itemBuilder: (context, index) => EpisodeListItem(episodes[index]),
            ),
          )
        ],
      ),
    );
  }
}
