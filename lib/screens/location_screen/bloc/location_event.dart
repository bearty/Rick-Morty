part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class FetchLocationData extends LocationEvent {
  final String id;
  FetchLocationData(this.id);
}
