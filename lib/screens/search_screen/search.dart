import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricknmorty/components/character_list_item.dart';
import 'package:ricknmorty/components/episode_list_item.dart';
import 'package:ricknmorty/components/green_circle_loader.dart';
import 'package:ricknmorty/data/models/character.dart';
import 'package:ricknmorty/data/models/episode.dart';
import 'package:ricknmorty/data/models/location.dart';
import 'package:ricknmorty/screens/main_screen/src/location_item.dart';
import 'package:ricknmorty/screens/search_screen/bloc/search_bloc.dart';
import 'package:ricknmorty/theme/color_theme.dart';

import 'src/search_app_bar.dart';

enum SearchType { character, location, episode }

class SearchScreen extends StatelessWidget {
  const SearchScreen({@required this.type});
  final SearchType type;
  @override
  Widget build(BuildContext context) {
    switch (type) {
      case SearchType.character:
        return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
          return Scaffold(
            appBar: SearchAppBar(
              text: state.searchText,
              type: type,
              onSearch: (String text) {
                context.read<SearchBloc>()..add(SearchCharactersEvent(text));
              },
            ),
            body: state.loading
                ? Center(child: GreenCircleLoader())
                : SingleChildScrollView(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                    physics: state.characters.isEmpty ? NeverScrollableScrollPhysics() : BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 24),
                          child: Text('РЕЗУЛЬТАТЫ ПОИСКА', style: TextStyle(color: AppColors.gray, letterSpacing: 1.5)),
                        ),
                        state.characters.isEmpty
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
                                itemCount: state.characters.length,
                                itemBuilder: (context, index) => CharacterListItem(state.characters[index]),
                              ),
                      ],
                    ),
                  ),
          );
        });

        break;
      case SearchType.location:
        return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
          return Scaffold(
            appBar: SearchAppBar(
              text: state.searchText,
              type: type,
              onSearch: (String text) {
                context.read<SearchBloc>()..add(SearchLocationsEvent(text));
              },
            ),
            body: state.loading
                ? Center(child: GreenCircleLoader())
                : SingleChildScrollView(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                    physics: state.locations.isEmpty ? NeverScrollableScrollPhysics() : BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 24),
                          child: Text('РЕЗУЛЬТАТЫ ПОИСКА', style: TextStyle(color: AppColors.gray, letterSpacing: 1.5)),
                        ),
                        state.locations.isEmpty
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
                                itemCount: state.locations.length,
                                itemBuilder: (context, index) => LocationItem(state.locations[index]),
                                separatorBuilder: (BuildContext context, int index) => SizedBox(height: 24),
                              ),
                      ],
                    ),
                  ),
          );
        });

        break;
      case SearchType.episode:
        return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
          return Scaffold(
            appBar: SearchAppBar(
              text: state.searchText,
              type: type,
              onSearch: (String text) {
                context.read<SearchBloc>()..add(SearchEpisodesEvent(text));
              },
            ),
            body: state.loading
                ? Center(child: GreenCircleLoader())
                : SingleChildScrollView(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                    physics: state.episodes.isEmpty ? NeverScrollableScrollPhysics() : BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 24),
                          child: Text('РЕЗУЛЬТАТЫ ПОИСКА', style: TextStyle(color: AppColors.gray, letterSpacing: 1.5)),
                        ),
                        state.episodes.isEmpty
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
                                itemCount: state.episodes.length,
                                itemBuilder: (context, index) => EpisodeListItem(state.episodes[index]),
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
          body: Center(child: Text("Произошла ошибка")),
        );
    }
  }
}
