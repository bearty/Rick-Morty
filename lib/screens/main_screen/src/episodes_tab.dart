import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricknmorty/components/episode_list_item.dart';
import 'package:ricknmorty/components/green_circle_loader.dart';
import 'package:ricknmorty/data/dummy.dart';
import 'package:ricknmorty/data/models/episode.dart';
import 'package:ricknmorty/screens/main_screen/bloc/episodes_bloc.dart';
import 'package:ricknmorty/screens/main_screen/bloc/locations_bloc.dart';
import 'package:ricknmorty/screens/main_screen/src/location_item.dart';
import 'package:ricknmorty/screens/main_screen/src/search.dart';
import 'package:ricknmorty/screens/search_screen/search.dart';
import 'package:ricknmorty/theme/color_theme.dart';

class EpisodesTab extends StatelessWidget {
  const EpisodesTab({Key key}) : super(key: key);

  Widget EpisodesList(List<Episode> episodes) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 16, right: 16, top: 10),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: episodes.length,
        itemBuilder: (context, index) => EpisodeListItem(episodes[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EpisodesBloc, EpisodesState>(builder: (context, state) {
      switch (state.status) {
        case EpisodesStatus.failure:
          return SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Ошибка при загрузке'),
                TextButton(
                  onPressed: () => context.read<EpisodesBloc>()..add(EpisodesFetch()),
                  child: Text('Попробовать еще раз'),
                )
              ],
            ),
          );
        // return const Center(child: Text('Ошибка при загрузке'));
        case EpisodesStatus.success:
          if (state.seasons.isEmpty) {
            return const Center(child: Text('Список пуст'));
          }
          return DefaultTabController(
            length: state.seasons.length,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                title: SearchBar(
                    placeholder: "Найти эпизод",
                    onSearch: (String text) {
                      context.read<EpisodesBloc>()..add(EpisodesSearch(text));
                      Navigator.pushNamed(context, '/search', arguments: {'type': SearchType.episode, 'text': text, 'data': state.allEpisodes});
                    }),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(50.0),
                  child: TabBar(
                    isScrollable: true,
                    indicatorColor: Theme.of(context).textTheme.bodyText1.color,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: Theme.of(context).textTheme.bodyText1.color,
                    unselectedLabelColor: Theme.of(context).textTheme.subtitle2.color,
                    tabs: List.generate(state.seasons.length, (index) {
                      int key = state.seasons.keys.elementAt(index);
                      return Tab(text: "СЕЗОН $key");
                    }),
                  ),
                ),
              ),
              body: TabBarView(
                children: List.generate(state.seasons.length, (index) {
                  int key = state.seasons.keys.elementAt(index);
                  return EpisodesList(state.seasons[key]);
                }),
              ),
            ),
          );
        default:
          return const Center(child: GreenCircleLoader());
      }
    });
  }
}
