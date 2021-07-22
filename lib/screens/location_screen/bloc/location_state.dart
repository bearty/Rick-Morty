part of 'location_bloc.dart';

enum LocationStatus { initial, success, failure }

class LocationState extends Equatable {
  const LocationState({this.status, this.characters, this.location});

  final LocationStatus status;
  final List<Character> characters;
  final Location location;

  LocationState copyWith({
    LocationStatus status,
    Location location,
    List<Character> characters,
  }) {
    return LocationState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      location: location ?? this.location,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status }''';
  }

  @override
  List<Object> get props => [status, characters, location];
}

class LocationInitial extends LocationState {}
