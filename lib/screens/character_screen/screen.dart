import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ricknmorty/components/blured_image.dart';
import 'package:ricknmorty/components/custom_app_bar.dart';
import 'package:ricknmorty/components/custom_circle_button.dart';
import 'package:ricknmorty/components/green_circle_loader.dart';
import 'package:ricknmorty/data/dummy.dart';
import 'package:ricknmorty/resources/main_icons.dart';
import 'package:ricknmorty/data/models/character.dart';
import 'package:ricknmorty/screens/main_screen/bloc/characters_bloc.dart';
import 'package:ricknmorty/screens/character_screen/bloc/character_bloc.dart';
import 'package:ricknmorty/screens/character_screen/src/episodes.dart';
import 'package:ricknmorty/screens/character_screen/src/info.dart';
import 'package:ricknmorty/theme/color_theme.dart';

import 'bloc/character_bloc.dart';
/*
class CharacterScreen extends StatefulWidget {
  final Character character;
  CharacterScreen({this.character});
  @override
  _CharacterScreenState createState() => _CharacterScreenState();
}*/

class CharacterScreen extends StatelessWidget {
  final String id;
  CharacterScreen({this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      extendBodyBehindAppBar: true,
      body: BlocProvider(
        create: (context) => CharacterBloc()..add(FetchCharacterData(id)),
        child: BlocBuilder<CharacterBloc, CharacterState>(
          builder: (context, state) {
            switch (state.status) {
              case CharacterStatus.failure:
                return const Center(child: Text('Ошибка при загрузке'));
              case CharacterStatus.success:
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 218,
                        child: Stack(
                          alignment: Alignment.center,
                          fit: StackFit.expand,
                          clipBehavior: Clip.none,
                          children: [
                            BluredImage(img: state.character.imageName),
                            Positioned(
                              bottom: -86,
                              child: CircleAvatar(
                                radius: 86,
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 78,
                                  backgroundImage: NetworkImage(state.character.imageName),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 86),
                      CharacterInfo(state.character),
                      Divider(
                        color: Theme.of(context).dividerColor,
                        height: 2,
                      ),
                      CharacterEpisodes(state.episodes),
                    ],
                  ),
                );
              default:
                return const Center(child: GreenCircleLoader());
            }
          },
        ),
      ),
    );
  }
}
