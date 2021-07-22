import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:ricknmorty/data/models/character.dart';
import 'package:ricknmorty/data/network/service_api.dart';

part 'characters_event.dart';
part 'characters_state.dart';

const _charactersLimit = 1000;

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  CharactersBloc() : super(CharactersInitial());

  @override
  Stream<CharactersState> mapEventToState(
    CharactersEvent event,
  ) async* {
    if (event is CharactersFetch) {
      if (!state.loading && !state.hasReachedMax) {
        yield state.copyWith(loading: true);
        yield await _mapCharacterFetchedToState(state);
      } else {
        yield state;
      }
    }

    if (event is CharactersSwitchIsGrid) {
      yield state.copyWith(isGrid: !state.isGrid);
    }

    if (event is CharactersSetSort) {
      yield state.copyWith(sortForward: event.sortForward);
    }

    if (event is CharactersSetStatusFilter) {
      yield await _chageStatusFilter(event.status, state);
    }

    if (event is CharactersSetGenderFilter) {
      yield await _chageGenderFilter(event.gender, state);
    }

    if (event is CharactersApplyFilters) {
      yield await _applyFilters(state);
    }

    if (event is CharactersResetFilters) {
      yield state.copyWith(sortForward: true, filterGender: [], filterStatus: []);
    }

    if (event is CharactersSearch) {
      yield state.copyWith(searchText: event.text);
    }
  }

  Future<CharactersState> _chageStatusFilter(int status, CharactersState state) async {
    List<int> newStatusFilter = List.from(state.filterStatus);
    if (state.filterStatus.contains(status))
      newStatusFilter.removeWhere((element) => element == status);
    else
      newStatusFilter.add(status);
    return state.copyWith(filterStatus: newStatusFilter);
  }

  Future<CharactersState> _chageGenderFilter(int gender, CharactersState state) async {
    List<int> newGenderFilter = List.from(state.filterGender);
    if (state.filterGender.contains(gender))
      newGenderFilter.removeWhere((element) => element == gender);
    else
      newGenderFilter.add(gender);
    return state.copyWith(filterGender: newGenderFilter);
  }

  Future<CharactersState> _applyFilters(CharactersState state) async {
    List<Character> newCharacters = [];
    //Filters
    if (state.filterGender.isNotEmpty && state.filterStatus.isEmpty) {
      newCharacters = state.allCharacters.where((element) => state.filterGender.contains(element.gender)).toList();
    } else if (state.filterGender.isEmpty && state.filterStatus.isNotEmpty) {
      newCharacters = state.allCharacters.where((element) => state.filterStatus.contains(element.status)).toList();
    } else if (state.filterGender.isNotEmpty && state.filterStatus.isNotEmpty) {
      newCharacters =
          state.allCharacters.where((element) => state.filterGender.contains(element.gender) && state.filterStatus.contains(element.status)).toList();
    } else {
      newCharacters = state.allCharacters;
    }
    //Sort Ascend or Descend
    if (state.sortForward) {
      newCharacters.sort((a, b) => a.fullName.compareTo(b.fullName));
    } else {
      newCharacters.sort((b, a) => a.fullName.compareTo(b.fullName));
    }
    return state.copyWith(characters: List.from(newCharacters));
  }

  Future<CharactersState> _mapCharacterFetchedToState(CharactersState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == CharactersStatus.initial) {
        final characters = await _fetchCharacters(state.sortForward);
        return state.copyWith(
          status: CharactersStatus.success,
          characters: characters,
          allCharacters: characters,
          hasReachedMax: false,
          page: state.page + 1,
          loading: false,
        );
      }
      final characters = await _fetchCharacters(state.sortForward);
      return characters.isEmpty
          ? state.copyWith(hasReachedMax: true, loading: false)
          : state.copyWith(
              status: CharactersStatus.success,
              characters: List.of(state.characters)..addAll(characters),
              allCharacters: List.of(state.allCharacters)..addAll(characters),
              hasReachedMax: false,
              page: state.page + 1,
              loading: false,
            );
    } on Exception {
      return state.copyWith(status: CharactersStatus.failure, loading: false);
    }
  }

  Future<List<Character>> _fetchCharacters(bool sortForward) async {
    try {
      List<Character> output = [];
      var response = await ServiceApi().dio.get("Characters/GetAll", queryParameters: {"PageNumber": state.page, "PageSize": _charactersLimit});

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
      if (sortForward) {
        output.sort((a, b) => a.fullName.compareTo(b.fullName));
      } else {
        output.sort((b, a) => a.fullName.compareTo(b.fullName));
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
}
