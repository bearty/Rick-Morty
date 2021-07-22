part of 'episode_bloc.dart';

enum EpisodeStatus { initial, success, failure }

class EpisodeState extends Equatable {
  const EpisodeState({this.status, this.characters, this.episode});

  final EpisodeStatus status;
  final List<Character> characters;
  final Episode episode;

  EpisodeState copyWith({
    EpisodeStatus status,
    Episode episode,
    List<Character> characters,
  }) {
    return EpisodeState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      episode: episode ?? this.episode,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status }''';
  }

  @override
  List<Object> get props => [status, characters, episode];
}

class EpisodeInitial extends EpisodeState {}
