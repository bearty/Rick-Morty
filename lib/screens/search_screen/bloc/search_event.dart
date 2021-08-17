part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SetLoadingStatusEvent extends SearchEvent {
  final bool status;
  SetLoadingStatusEvent(this.status);
}

class SearchCharactersEvent extends SearchEvent {
  final String text;
  SearchCharactersEvent(this.text);
}

class SearchLocationsEvent extends SearchEvent {
  final String text;
  SearchLocationsEvent(this.text);
}

class SearchEpisodesEvent extends SearchEvent {
  final String text;
  SearchEpisodesEvent(this.text);
}
