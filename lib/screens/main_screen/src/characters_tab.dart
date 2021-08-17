import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricknmorty/components/green_circle_loader.dart';
import 'package:ricknmorty/screens/main_screen/bloc/characters_bloc.dart';
import 'package:ricknmorty/screens/main_screen/src/character_grid_item.dart';
import 'package:ricknmorty/components/character_list_item.dart';
import 'package:ricknmorty/screens/main_screen/src/search.dart';
import 'package:ricknmorty/screens/search_screen/bloc/search_bloc.dart';
import 'package:ricknmorty/screens/search_screen/search.dart';
import 'package:ricknmorty/theme/color_theme.dart';

import 'search_bar_bottom.dart';

class CharactersTab extends StatelessWidget {
  const CharactersTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharactersBloc, CharactersState>(
      builder: (context, state) {
        switch (state.status) {
          case CharactersStatus.failure:
            return const Center(child: Text('Ошибка при загрузке'));
          case CharactersStatus.success:
            if (state.allCharacters.isEmpty) {
              return const Center(child: Text('Список пуст'));
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                title: SearchBar(
                  placeholder: "Найти персонажа",
                  onFilter: () => Navigator.pushNamed(context, '/characters-filter'),
                  onSearch: (String text) {
                    context.read<SearchBloc>()..add(SearchCharactersEvent(text));
                    Navigator.pushNamed(context, '/search', arguments: {'type': SearchType.character, 'text': text});
                  },
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(50.0),
                  child: SearchBarBottom(
                    isGrid: state.isGrid,
                    text: 'ВСЕГО ПЕРСОНАЖЕЙ: ${state.characters.length}',
                    onPress: () => context.read<CharactersBloc>()..add(CharactersSwitchIsGrid()),
                  ),
                ),
              ),
              body: NotificationListener<ScrollEndNotification>(
                onNotification: (ScrollEndNotification scrollEnd) {
                  var metrics = scrollEnd.metrics;
                  if (metrics.atEdge) {
                    if (metrics.pixels == 0)
                      print('At top');
                    else {
                      print('At bottom');
                      // context.read<CharactersBloc>()..add(CharactersFetch());
                    }
                  }
                  return true;
                },
                child: state.characters.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/filter_not_finded.png'),
                            Text(
                              'По данным фильтра ничего \nне найдено',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                        child: state.isGrid
                            ? GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 24,
                                  crossAxisSpacing: 18,
                                ),
                                itemCount: state.characters.length,
                                itemBuilder: (context, index) => CharacterGridItem(state.characters[index]),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: state.characters.length,
                                itemBuilder: (context, index) => CharacterListItem(state.characters[index]),
                              ),
                      ),
              ),
            );
          default:
            return const Center(child: GreenCircleLoader());
        }
      },
    );
  }
}
