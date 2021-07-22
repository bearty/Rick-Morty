import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:ricknmorty/data/models/episode.dart';
import 'package:ricknmorty/data/network/service_api.dart';

part 'episodes_event.dart';
part 'episodes_state.dart';

const _episodesLimit = 1000;

class EpisodesBloc extends Bloc<EpisodesEvent, EpisodesState> {
  EpisodesBloc() : super(EpisodesInitial());

  @override
  Stream<EpisodesState> mapEventToState(
    EpisodesEvent event,
  ) async* {
    if (event is EpisodesFetch) {
      if (!state.loading && !state.hasReachedMax) {
        yield state.copyWith(loading: true);
        yield await _mapEpisodeFetchedToState(state);
      } else {
        yield state;
      }
    }
    if (event is EpisodesSearch) {
      yield state.copyWith(searchText: event.text);
    }
  }

  Future<EpisodesState> _mapEpisodeFetchedToState(EpisodesState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == EpisodesStatus.initial) {
        final data = await _fetchEpisodes();
        return state.copyWith(
          status: EpisodesStatus.success,
          seasons: data.seasons,
          allEpisodes: data.allEpisodes,
          hasReachedMax: false,
          page: state.page + 1,
          loading: false,
          total: data.totalRecords,
        );
      }
      final data = await _fetchEpisodes();
      return data.seasons.isEmpty
          ? state.copyWith(hasReachedMax: true, loading: false)
          : state.copyWith(
              status: EpisodesStatus.success,
              seasons: data.seasons,
              allEpisodes: data.allEpisodes,
              hasReachedMax: false,
              page: state.page + 1,
              loading: false,
              total: data.totalRecords,
            );
    } on Exception {
      return state.copyWith(status: EpisodesStatus.failure, loading: false);
    }
  }

  Future<EpisodeRequest> _fetchEpisodes() async {
    try {
      EpisodeRequest request = EpisodeRequest();
      Map<int, List<Episode>> seasons = {};
      List<Episode> allEpisodes = [];
      var response = await ServiceApi().dio.get("Episodes/GetAll", queryParameters: {"PageNumber": state.page, "PageSize": _episodesLimit});

      for (var i = 0; i < response.data['data'].length; i++) {
        Episode episode = Episode.fromJson(response.data['data'][i]);
        if (!seasons.containsKey(episode.season)) {
          seasons[episode.season] = <Episode>[];
        }
        seasons[episode.season].add(episode);
        allEpisodes.add(episode);
      }
      seasons.forEach((key, season) => season.sort((a, b) => a.series.compareTo(b.series)));
      request.totalRecords = response.data['totalRecords'];
      request.seasons = seasons;
      request.allEpisodes = allEpisodes;
      return request;
    } catch (e) {
      if (e is DioError) {
        print(e.requestOptions.uri);
      }
      print(e);
      throw Exception('error fetching posts');
    }
  }
}
