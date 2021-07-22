import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ricknmorty/components/blured_image.dart';
import 'package:ricknmorty/components/custom_app_bar.dart';
import 'package:ricknmorty/components/character_list_item.dart';
import 'package:ricknmorty/components/green_circle_loader.dart';
import 'package:ricknmorty/data/dummy.dart';
import 'package:ricknmorty/data/models/episode.dart';
import 'package:ricknmorty/resources/main_icons.dart';
import 'package:ricknmorty/screens/episode_screen/src/characters.dart';
import 'package:ricknmorty/screens/episode_screen/src/info.dart';
import 'package:ricknmorty/theme/color_theme.dart';

import 'bloc/episode_bloc.dart';

class EpisodeScreen extends StatelessWidget {
  final String id;
  EpisodeScreen({this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      extendBodyBehindAppBar: true,
      body: BlocProvider(
        create: (context) => EpisodeBloc()..add(FetchEpisodeData(id)),
        child: BlocBuilder<EpisodeBloc, EpisodeState>(
          builder: (context, state) {
            switch (state.status) {
              case EpisodeStatus.failure:
                return const Center(child: Text('Ошибка при загрузке'));
              case EpisodeStatus.success:
                if (state.characters.isEmpty) return const SizedBox();

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 298,
                        child: Stack(
                          alignment: Alignment.center,
                          fit: StackFit.expand,
                          clipBehavior: Clip.none,
                          children: [
                            BluredImage(
                              img: state.episode.imageName,
                              blur: false,
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 34,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(26),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -16,
                              child: GestureDetector(
                                onTap: () => print("play episode ${state.episode.name}"),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: ColorPalette.blue,
                                  child: SvgPicture.asset(
                                    MainIcons.play,
                                    color: ColorPalette.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 32),
                      EpisodeInfo(state.episode),
                      Divider(
                        color: ColorPalette.widget_bg,
                        height: 2,
                      ),
                      const SizedBox(height: 36),
                      EpisodeCharacters(state.characters),
                      /*Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 6,
                            itemBuilder: (context, index) => CharacterListItem(id: index),
                          ),
                        ),
                      )*/
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
/*
    return Scaffold(
      appBar: CustomAppBar(),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 298,
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  BluredImage(
                    img: episode.imageName,
                    blur: false,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 34,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(26),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -16,
                    child: GestureDetector(
                      onTap: () => print("play episode ${episode.name}"),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: ColorPalette.blue,
                        child: SvgPicture.asset(
                          MainIcons.play,
                          color: ColorPalette.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            EpisodeInfo(episode),
            Divider(
              color: ColorPalette.widget_bg,
              height: 2,
            ),
            const SizedBox(height: 36),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Персонажи',
                style: TextStyle(
                  fontSize: 20,
                  color: ColorPalette.white,
                ),
              ),
            ),
            const SizedBox(height: 24),
            /*Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (context, index) => CharacterListItem(id: index),
                ),
              ),
            )*/
          ],
        ),
      ),
    );*/
  }
}
