part of 'locations_bloc.dart';

enum LocationsStatus { initial, success, failure }

class LocationsState extends Equatable {
  const LocationsState({
    this.status = LocationsStatus.initial,
    this.sortForward = true,
    this.loading = false,
    this.locations = const <Location>[],
    this.allLocations = const <Location>[],
    this.searchText,
    this.locationMeasurements = const <String>[],
    this.locationTypes = const <String>[],
    this.measurementFilter = '',
    this.typeFilter = '',
    this.hasReachedMax = false,
    this.isGrid = false,
    this.page = 1,
    this.total = 0,
  });

  final LocationsStatus status;
  final bool sortForward;
  final bool loading;
  final List<Location> locations;
  final List<Location> allLocations;
  final String searchText;
  final List<String> locationMeasurements;
  final List<String> locationTypes;
  final String measurementFilter;
  final String typeFilter;
  final bool hasReachedMax;
  final bool isGrid;
  final int page;
  final int total;

  LocationsState copyWith({
    LocationsStatus status,
    bool sortForward,
    bool loading,
    List<Location> locations,
    List<Location> allLocations,
    String searchText,
    List<String> locationMeasurements,
    List<String> locationTypes,
    String measurementFilter,
    String typeFilter,
    bool hasReachedMax,
    bool isGrid,
    int page,
    int total,
  }) {
    return LocationsState(
      status: status ?? this.status,
      sortForward: sortForward ?? this.sortForward,
      loading: loading ?? this.loading,
      locations: locations ?? this.locations,
      allLocations: allLocations ?? this.allLocations,
      searchText: searchText ?? this.searchText,
      locationMeasurements: locationMeasurements ?? this.locationMeasurements,
      locationTypes: locationTypes ?? this.locationTypes,
      measurementFilter: measurementFilter ?? this.measurementFilter,
      typeFilter: typeFilter ?? this.typeFilter,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isGrid: isGrid ?? this.isGrid,
      page: page ?? this.page,
      total: total ?? this.total,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, page: $page, locations: ${locations.length} }''';
  }

  @override
  List<Object> get props => [
        status,
        sortForward,
        loading,
        locations,
        allLocations,
        searchText,
        locationMeasurements,
        locationTypes,
        measurementFilter,
        typeFilter,
        hasReachedMax,
        isGrid,
        page,
        total,
      ];
}

class LocationsInitial extends LocationsState {}
