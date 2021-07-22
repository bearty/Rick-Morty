import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ricknmorty/components/episode_list_item.dart';
import 'package:ricknmorty/data/dummy.dart';
import 'package:ricknmorty/data/models/episode.dart';
import 'package:ricknmorty/theme/color_theme.dart';

class CharacterEpisodes extends StatefulWidget {
  @override
  _CharacterEpisodesState createState() => _CharacterEpisodesState();
}

class _CharacterEpisodesState extends State<CharacterEpisodes> {
  @override
  Widget build(BuildContext context) {
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
                  color: ColorPalette.white,
                  fontSize: 20,
                ),
              ),
              TextButton(
                onPressed: () => print("All episodes"),
                child: Text(
                  'Все эпизоды',
                  style: TextStyle(
                    color: ColorPalette.gray_text,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) => EpisodeListItem(Episode()),
          )
        ],
      ),
    );
  }
}
