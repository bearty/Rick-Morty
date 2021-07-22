part of 'episodes_bloc.dart';

abstract class EpisodesEvent extends Equatable {
  const EpisodesEvent();

  @override
  List<Object> get props => [];
}

class EpisodesFetch extends EpisodesEvent {}

class EpisodesSearch extends EpisodesEvent {
  final String text;
  EpisodesSearch(this.text);
}
