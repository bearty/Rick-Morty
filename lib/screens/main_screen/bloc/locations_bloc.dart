import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:ricknmorty/data/models/location.dart';
import 'package:ricknmorty/data/network/service_api.dart';

part 'locations_event.dart';
part 'locations_state.dart';

const _locationsLimit = 1000;

class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  LocationsBloc() : super(LocationsInitial());

  @override
  Stream<LocationsState> mapEventToState(
    LocationsEvent event,
  ) async* {
    if (event is LocationsFetch) {
      if (!state.loading && !state.hasReachedMax) {
        yield state.copyWith(loading: true);
        yield await _mapLocationFetchedToState(state);
      } else {
        yield state;
      }
    }
    if (event is LocationsSetSort) {
      yield state.copyWith(sortForward: event.sortForward);
    }
    if (event is SetLocationTypeFilter) {
      yield state.copyWith(typeFilter: event.type);
    }
    if (event is SetLocationMeasurementFilter) {
      yield state.copyWith(measurementFilter: event.measurement);
    }

    if (event is LocationsApplyFilters) {
      yield await _applyFilters(state);
    }

    if (event is LocationsResetFilters) {
      yield state.copyWith(sortForward: true, typeFilter: "", measurementFilter: "");
    }

    if (event is LocationsSearch) {
      yield state.copyWith(searchText: event.text);
    }
  }

  Future<LocationsState> _applyFilters(LocationsState state) async {
    List<Location> newLocations = [];
    //Filters
    if (state.typeFilter.isNotEmpty && state.measurementFilter.isEmpty) {
      newLocations = state.allLocations.where((element) => state.typeFilter == element.type).toList();
    } else if (state.typeFilter.isEmpty && state.measurementFilter.isNotEmpty) {
      newLocations = state.allLocations.where((element) => state.measurementFilter == element.measurements).toList();
    } else if (state.typeFilter.isNotEmpty && state.measurementFilter.isNotEmpty) {
      newLocations =
          state.allLocations.where((element) => state.typeFilter == element.type && state.measurementFilter == element.measurements).toList();
    } else {
      newLocations = state.allLocations;
    }
    //Sort Ascend or Descend
    if (state.sortForward) {
      newLocations.sort((a, b) => a.name.compareTo(b.name));
    } else {
      newLocations.sort((b, a) => a.name.compareTo(b.name));
    }
    return state.copyWith(locations: List.from(newLocations));
  }

  Future<LocationsState> _mapLocationFetchedToState(LocationsState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == LocationsStatus.initial) {
        final data = await _fetchLocations(state.sortForward);
        return state.copyWith(
          status: LocationsStatus.success,
          locations: data.locations,
          allLocations: data.locations,
          hasReachedMax: false,
          page: state.page + 1,
          loading: false,
          total: data.totalRecords,
          locationMeasurements: data.measurements,
          locationTypes: data.types,
        );
      }
      final data = await _fetchLocations(state.sortForward);
      return data.locations.isEmpty
          ? state.copyWith(hasReachedMax: true, loading: false)
          : state.copyWith(
              status: LocationsStatus.success,
              locations: List.of(state.locations)..addAll(data.locations),
              allLocations: List.of(state.allLocations)..addAll(data.locations),
              hasReachedMax: false,
              page: state.page + 1,
              loading: false,
              total: data.totalRecords,
              locationMeasurements: data.measurements,
              locationTypes: data.types,
            );
    } on Exception {
      return state.copyWith(status: LocationsStatus.failure, loading: false);
    }
  }

  Future<LocationRequest> _fetchLocations(bool sortForward) async {
    try {
      LocationRequest request = LocationRequest();
      List<Location> locationsList = [];
      List<String> locationMeasurements = [];
      List<String> locationTypes = [];
      var response = await ServiceApi().dio.get("Locations/GetAll", queryParameters: {"PageNumber": state.page, "PageSize": _locationsLimit});
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
      if (sortForward) {
        locationsList.sort((a, b) => a.name.compareTo(b.name));
      } else {
        locationsList.sort((b, a) => a.name.compareTo(b.name));
      }
      request.totalRecords = response.data['totalRecords'];
      request.locations = locationsList;
      request.measurements = locationMeasurements;
      request.types = locationTypes;

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
