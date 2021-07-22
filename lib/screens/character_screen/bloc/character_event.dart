part of 'character_bloc.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent();

  @override
  List<Object> get props => [];
}

class FetchCharacterData extends CharacterEvent {
  final String id;
  FetchCharacterData(this.id);
}
