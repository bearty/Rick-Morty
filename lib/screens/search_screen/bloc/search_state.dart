part of 'search_bloc.dart';

class SearchState extends Equatable {
  const SearchState({
    this.loading = true,
    this.searchText = "",
    this.characters = const <Character>[],
    this.locations = const <Location>[],
    this.episodes = const <Episode>[],
  });

  final bool loading;
  final String searchText;
  final List<Character> characters;
  final List<Location> locations;
  final List<Episode> episodes;

  SearchState copyWith({
    bool loading,
    String searchText,
    List<Character> characters,
    List<Location> locations,
    List<Episode> episodes,
  }) {
    return SearchState(
      loading: loading ?? this.loading,
      searchText: searchText ?? this.searchText,
      characters: characters ?? this.characters,
      locations: locations ?? this.locations,
      episodes: episodes ?? this.episodes,
    );
  }

  @override
  List<Object> get props => [loading, searchText, characters, locations, episodes];
}

class SearchInitial extends SearchState {}
