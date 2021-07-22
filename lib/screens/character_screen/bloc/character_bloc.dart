import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:ricknmorty/data/models/episode.dart';
import 'package:ricknmorty/data/models/character.dart';
import 'package:ricknmorty/data/network/service_api.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  CharacterBloc() : super(CharacterInitial());

  @override
  Stream<CharacterState> mapEventToState(
    CharacterEvent event,
  ) async* {
    if (event is FetchCharacterData) {
      yield await _fetchCharacterData(event.id, state);
    }
  }

  Future<CharacterState> _fetchCharacterData(String id, CharacterState state) async {
    try {
      var response = await ServiceApi().dio.get("Characters/GetById", queryParameters: {"Id": id});
      List<Episode> episodes = [];
      for (var episode in response.data['data']['episodes']) {
        episodes.add(Episode.fromJson(episode));
      }
      String locationName = response.data['data']['location']['name'];
      String locationId = response.data['data']['location']['id'];
      response.data['data']['location'] = locationName;
      response.data['data']['locationId'] = locationId;
      response.data['data'].remove('placeOfBirth');
      Character character = Character.fromJson(response.data['data']);

      return state.copyWith(
        status: CharacterStatus.success,
        episodes: episodes,
        character: character,
      );
    } catch (e) {
      if (e is DioError) {
        print(e.requestOptions.uri);
      }
      print(e);
      return state.copyWith(
        status: CharacterStatus.failure,
      );
    }
  }
}
