import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:ricknmorty/data/models/character.dart';
import 'package:ricknmorty/data/models/episode.dart';
import 'package:ricknmorty/data/models/location.dart';
import 'package:ricknmorty/data/network/service_api.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial());

  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
    if (event is FetchLocationData) {
      yield await _fetchLocationCharacters(event.id, state);
    }
  }

  Future<LocationState> _fetchLocationCharacters(String id, LocationState state) async {
    try {
      var response = await ServiceApi().dio.get("Locations/GetById", queryParameters: {"Id": id});
      List<Character> characters = [];
      Location location = Location.fromJson(response.data['data']);
      for (var episode in response.data['data']['characters']) {
        characters.add(Character.fromJson(episode));
      }

      return state.copyWith(status: LocationStatus.success, characters: characters, location: location);
    } catch (e) {
      if (e is DioError) {
        print(e.requestOptions.uri);
      }
      print(e);
      return state.copyWith(
        status: LocationStatus.failure,
      );
    }
  }
}
