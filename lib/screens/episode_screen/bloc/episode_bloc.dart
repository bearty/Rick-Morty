import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:ricknmorty/data/models/character.dart';
import 'package:ricknmorty/data/models/episode.dart';
import 'package:ricknmorty/data/models/episode.dart';
import 'package:ricknmorty/data/network/service_api.dart';

part 'episode_event.dart';
part 'episode_state.dart';

class EpisodeBloc extends Bloc<EpisodeEvent, EpisodeState> {
  EpisodeBloc() : super(EpisodeInitial());

  @override
  Stream<EpisodeState> mapEventToState(
    EpisodeEvent event,
  ) async* {
    if (event is FetchEpisodeData) {
      yield await _fetchEpisodeCharacters(event.id, state);
    }
  }

  Future<EpisodeState> _fetchEpisodeCharacters(String id, EpisodeState state) async {
    try {
      var response = await ServiceApi().dio.get("Episodes/GetById", queryParameters: {"Id": id});
      List<Character> characters = [];
      Episode episode = Episode.fromJson(response.data['data']);
      for (var episode in response.data['data']['characters']) {
        characters.add(Character.fromJson(episode));
      }

      return state.copyWith(status: EpisodeStatus.success, characters: characters, episode: episode);
    } catch (e) {
      if (e is DioError) {
        print(e.requestOptions.uri);
      }
      print(e);
      return state.copyWith(
        status: EpisodeStatus.failure,
      );
    }
  }
}
