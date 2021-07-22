part of 'characters_bloc.dart';

abstract class CharactersEvent extends Equatable {
  const CharactersEvent();

  @override
  List<Object> get props => [];
}

class CharactersFetch extends CharactersEvent {}

class CharactersSwitchIsGrid extends CharactersEvent {}

class CharactersSetStatusFilter extends CharactersEvent {
  final int status;
  CharactersSetStatusFilter(this.status);
}

class CharactersSetGenderFilter extends CharactersEvent {
  final int gender;
  CharactersSetGenderFilter(this.gender);
}

class CharactersSetSort extends CharactersEvent {
  final bool sortForward;
  CharactersSetSort(this.sortForward);
}

class CharactersResetFilters extends CharactersEvent {}

class CharactersApplyFilters extends CharactersEvent {}

class CharactersSearch extends CharactersEvent {
  final String text;
  CharactersSearch(this.text);
}
