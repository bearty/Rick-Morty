part of 'characters_bloc.dart';

enum CharactersStatus { initial, success, failure }

class CharactersState extends Equatable {
  const CharactersState({
    this.status = CharactersStatus.initial,
    this.sortForward = true,
    this.loading = false,
    this.filterStatus = const [],
    this.filterGender = const [],
    this.characters = const <Character>[],
    this.allCharacters = const <Character>[],
    this.searchText,
    this.hasReachedMax = false,
    this.isGrid = false,
    this.page = 1,
  });

  final CharactersStatus status;
  final bool sortForward;
  final bool loading;
  final List<int> filterStatus;
  final List<int> filterGender;
  final List<Character> characters;
  final List<Character> allCharacters;
  final String searchText;
  final bool hasReachedMax;
  final bool isGrid;
  final int page;

  CharactersState copyWith({
    CharactersStatus status,
    bool sortForward,
    bool loading,
    List<int> filterStatus,
    List<int> filterGender,
    List<Character> characters,
    List<Character> allCharacters,
    String searchText,
    bool hasReachedMax,
    bool isGrid,
    int page,
  }) {
    return CharactersState(
      status: status ?? this.status,
      sortForward: sortForward ?? this.sortForward,
      loading: loading ?? this.loading,
      filterStatus: filterStatus ?? this.filterStatus,
      filterGender: filterGender ?? this.filterGender,
      characters: characters ?? this.characters,
      allCharacters: allCharacters ?? this.allCharacters,
      searchText: searchText ?? this.searchText,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isGrid: isGrid ?? this.isGrid,
      page: page ?? this.page,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, page: $page, characters: ${characters.length} }''';
  }

  @override
  List<Object> get props => [
        status,
        sortForward,
        loading,
        characters,
        allCharacters,
        searchText,
        hasReachedMax,
        isGrid,
        page,
        filterStatus,
        filterGender,
      ];
}

class CharactersInitial extends CharactersState {}

class CharactersIsGridState extends CharactersState {
  final bool isGrid;
  CharactersIsGridState({this.isGrid});
  @override
  List<Object> get props => [isGrid];
}
