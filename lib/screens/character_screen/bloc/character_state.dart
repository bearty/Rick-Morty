part of 'character_bloc.dart';

enum CharacterStatus { initial, success, failure }

class CharacterState extends Equatable {
  const CharacterState({this.status, this.character, this.episodes});

  final CharacterStatus status;
  final Character character;
  final List<Episode> episodes;

  CharacterState copyWith({
    CharacterStatus status,
    Character character,
    List<Episode> episodes,
  }) {
    return CharacterState(
      status: status ?? this.status,
      character: character ?? this.character,
      episodes: episodes ?? this.episodes,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status }''';
  }

  @override
  List<Object> get props => [status, character, episodes];
}

class CharacterInitial extends CharacterState {}
