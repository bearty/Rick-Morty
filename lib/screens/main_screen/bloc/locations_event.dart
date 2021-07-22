part of 'locations_bloc.dart';

abstract class LocationsEvent extends Equatable {
  const LocationsEvent();

  @override
  List<Object> get props => [];
}

class LocationsFetch extends LocationsEvent {}

class SetLocationTypeFilter extends LocationsEvent {
  final String type;
  SetLocationTypeFilter(this.type);
}

class SetLocationMeasurementFilter extends LocationsEvent {
  final String measurement;
  SetLocationMeasurementFilter(this.measurement);
}

class LocationsSetSort extends LocationsEvent {
  final bool sortForward;
  LocationsSetSort(this.sortForward);
}

class LocationsApplyFilters extends LocationsEvent {}

class LocationsResetFilters extends LocationsEvent {}

class LocationsSearch extends LocationsEvent {
  final String text;
  LocationsSearch(this.text);
}
