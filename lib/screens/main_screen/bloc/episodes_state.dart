part of 'episodes_bloc.dart';

enum EpisodesStatus { initial, success, failure }

class EpisodesState extends Equatable {
  const EpisodesState({
    this.status = EpisodesStatus.initial,
    this.loading = false,
    this.seasons = const {},
    this.allEpisodes = const <Episode>[],
    this.searchText,
    this.hasReachedMax = false,
    this.isGrid = false,
    this.page = 1,
    this.total = 0,
  });

  final EpisodesStatus status;
  final bool loading;
  final Map<int, List<Episode>> seasons;
  final List<Episode> allEpisodes;
  final String searchText;
  final bool hasReachedMax;
  final bool isGrid;
  final int page;
  final int total;

  EpisodesState copyWith({
    EpisodesStatus status,
    bool loading,
    Map<int, List<Episode>> seasons,
    List<Episode> allEpisodes,
    String searchText,
    bool hasReachedMax,
    bool isGrid,
    int page,
    int total,
  }) {
    return EpisodesState(
      status: status ?? this.status,
      loading: loading ?? this.loading,
      seasons: seasons ?? this.seasons,
      allEpisodes: allEpisodes ?? this.allEpisodes,
      searchText: searchText ?? this.searchText,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isGrid: isGrid ?? this.isGrid,
      page: page ?? this.page,
      total: total ?? this.total,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, page: $page, seasons: ${seasons.length} }''';
  }

  @override
  List<Object> get props => [
        status,
        loading,
        seasons,
        allEpisodes,
        searchText,
        hasReachedMax,
        isGrid,
        page,
        total,
      ];
}

class EpisodesInitial extends EpisodesState {}
