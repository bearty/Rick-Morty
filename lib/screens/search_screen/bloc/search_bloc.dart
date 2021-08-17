import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:ricknmorty/data/models/character.dart';
import 'package:ricknmorty/data/models/episode.dart';
import 'package:ricknmorty/data/models/location.dart';
import 'package:ricknmorty/data/network/service_api.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchCharactersEvent) {
      yield state.copyWith(loading: true, searchText: event.text);
      yield await _searchCharacters(event.text, state);
    }
    if (event is SearchLocationsEvent) {
      yield state.copyWith(loading: true, searchText: event.text);
      yield await _searchLocations(event.text, state);
    }
    if (event is SearchEpisodesEvent) {
      yield state.copyWith(loading: true, searchText: event.text);
      yield await _searchEpisodes(event.text, state);
    }
  }

  Future<SearchState> _searchCharacters(String text, SearchState state) async {
    final characters = await _fetchCharacters(text);
    return state.copyWith(
      characters: characters,
      loading: false,
    );
  }

  Future<SearchState> _searchLocations(String text, SearchState state) async {
    final locations = await _fetchLocations(text);
    return state.copyWith(
      locations: locations,
      loading: false,
    );
  }

  Future<SearchState> _searchEpisodes(String text, SearchState state) async {
    final episodes = await _fetchEpisodes(text);
    return state.copyWith(
      episodes: episodes,
      loading: false,
    );
  }

  Future<List<Character>> _fetchCharacters(String text) async {
    try {
      List<Character> output = [];
      var response = await ServiceApi().dio.get("/Characters/Filter", queryParameters: {"Name": text, "Status[]": "", "Gender[]": ""});

      for (var i = 0; i < response.data['data'].length; i++) {
        var item = response.data['data'][i];
        String locationName = item['location']['name'];
        String locationId = item['location']['id'];
        item['location'] = locationName;
        item['locationId'] = locationId;

        Character character = Character.fromJson(item);
        character.fullName = character.fullName.trim();

        output.add(character);
      }

      return output;
    } catch (e) {
      if (e is DioError) {
        print(e.requestOptions.uri);
      }
      print(e);
      throw Exception('error fetching posts');
    }
  }

  Future<List<Location>> _fetchLocations(String text) async {
    try {
      List<Location> locationsList = [];
      List<String> locationMeasurements = [];
      List<String> locationTypes = [];
      var response = await ServiceApi().dio.get("Locations/Filter", queryParameters: {"Name": text});
      for (var i = 0; i < response.data['data'].length; i++) {
        Location locations = Location.fromJson(response.data['data'][i]);
        locationsList.add(locations);
        if (!locationMeasurements.contains(locations.measurements) && locations.measurements.trim().isNotEmpty) {
          locationMeasurements.add(locations.measurements);
        }
        if (!locationTypes.contains(locations.type) && locations.type.trim().isNotEmpty) {
          locationTypes.add(locations.type);
        }
      }

      return locationsList;
    } catch (e) {
      if (e is DioError) {
        print(e.requestOptions.uri);
      }
      print(e);
      throw Exception('error fetching posts');
    }
  }

  Future<List<Episode>> _fetchEpisodes(String text) async {
    try {
      Map<int, List<Episode>> seasons = {};
      List<Episode> allEpisodes = [];
      var response = await ServiceApi().dio.get("Episodes/GetByName", queryParameters: {"Name": text});

      for (var i = 0; i < response.data['data'].length; i++) {
        Episode episode = Episode.fromJson(response.data['data'][i]);
        if (!seasons.containsKey(episode.season)) {
          seasons[episode.season] = <Episode>[];
        }
        seasons[episode.season].add(episode);
        allEpisodes.add(episode);
      }
      return allEpisodes;
    } catch (e) {
      if (e is DioError) {
        print(e.requestOptions.uri);
      }
      print(e);
      throw Exception('error fetching posts');
    }
  }
}
