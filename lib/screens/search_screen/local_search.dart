import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricknmorty/components/character_list_item.dart';
import 'package:ricknmorty/components/episode_list_item.dart';
import 'package:ricknmorty/data/models/character.dart';
import 'package:ricknmorty/data/models/episode.dart';
import 'package:ricknmorty/data/models/location.dart';
import 'package:ricknmorty/screens/main_screen/bloc/characters_bloc.dart';
import 'package:ricknmorty/screens/main_screen/bloc/episodes_bloc.dart';
import 'package:ricknmorty/screens/main_screen/bloc/locations_bloc.dart';
import 'package:ricknmorty/screens/main_screen/src/location_item.dart';
import 'package:ricknmorty/screens/search_screen/search.dart';
import 'package:ricknmorty/theme/color_theme.dart';

import 'src/search_app_bar.dart';

// enum SearchType { character, location, episode }

class LocalSearchScreen extends StatelessWidget {
  const LocalSearchScreen({@required this.type});
  final SearchType type;
  @override
  Widget build(BuildContext context) {
    switch (type) {
      case SearchType.character:
        return BlocBuilder<CharactersBloc, CharactersState>(builder: (context, state) {
          List<Character> finded =
              state.allCharacters.where((element) => element.fullName.contains(new RegExp(state.searchText.trim(), caseSensitive: false))).toList();
          bool isFinded = finded.isNotEmpty && state.searchText.trim().isNotEmpty;
          return Scaffold(
            appBar: SearchAppBar(
              text: state.searchText,
              type: type,
              onSearch: (String text) => context.read<CharactersBloc>()..add(CharactersSearch(text)),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              physics: isFinded ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 24),
                    child: Text('РЕЗУЛЬТАТЫ ПОИСКА', style: TextStyle(color: AppColors.gray, letterSpacing: 1.5)),
                  ),
                  !isFinded
                      ? Container(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/character_not_finded.png'),
                                const SizedBox(height: 28),
                                Text(
                                  'Персонаж с таким именем не найден',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Theme.of(context).accentColor, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: finded.length,
                          itemBuilder: (context, index) => CharacterListItem(finded[index]),
                        ),
                ],
              ),
            ),
          );
        });

        break;
      case SearchType.location:
        return BlocBuilder<LocationsBloc, LocationsState>(builder: (context, state) {
          List<Location> finded =
              state.allLocations.where((element) => element.name.contains(new RegExp(state.searchText.trim(), caseSensitive: false))).toList();
          bool isFinded = finded.isNotEmpty && state.searchText.trim().isNotEmpty;
          return Scaffold(
            appBar: SearchAppBar(
              text: state.searchText,
              type: type,
              onSearch: (String text) => context.read<LocationsBloc>()..add(LocationsSearch(text)),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              physics: isFinded ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 24),
                    child: Text('РЕЗУЛЬТАТЫ ПОИСКА', style: TextStyle(color: AppColors.gray, letterSpacing: 1.5)),
                  ),
                  !isFinded
                      ? Container(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/location_not_finded.png'),
                                const SizedBox(height: 28),
                                Text(
                                  'Локации с таким названием не найдено',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Theme.of(context).accentColor, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: finded.length,
                          itemBuilder: (context, index) => LocationItem(finded[index]),
                          separatorBuilder: (BuildContext context, int index) => SizedBox(height: 24),
                        ),
                ],
              ),
            ),
          );
        });

        break;
      case SearchType.episode:
        return BlocBuilder<EpisodesBloc, EpisodesState>(builder: (context, state) {
          List<Episode> finded =
              state.allEpisodes.where((element) => element.name.contains(new RegExp(state.searchText.trim(), caseSensitive: false))).toList();
          bool isFinded = finded.isNotEmpty && state.searchText.trim().isNotEmpty;
          return Scaffold(
            appBar: SearchAppBar(
              text: state.searchText,
              type: type,
              onSearch: (String text) => context.read<EpisodesBloc>()..add(EpisodesSearch(text)),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              physics: isFinded ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 24),
                    child: Text('РЕЗУЛЬТАТЫ ПОИСКА', style: TextStyle(color: AppColors.gray, letterSpacing: 1.5)),
                  ),
                  !isFinded
                      ? Container(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/episode_not_finded.png'),
                                const SizedBox(height: 28),
                                Text(
                                  'Эпизода с таким названием нет',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Theme.of(context).accentColor, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: finded.length,
                          itemBuilder: (context, index) => EpisodeListItem(finded[index]),
                          separatorBuilder: (BuildContext context, int index) => SizedBox(height: 24),
                        ),
                ],
              ),
            ),
          );
        });

        break;
      default:
        return Scaffold(
          // appBar: SearchAppBar(),
          body: Text("Произошла ошибка"),
        );
    }
  }
}
