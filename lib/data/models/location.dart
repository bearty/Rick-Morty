class LocationRequest {
  LocationRequest({
    this.totalRecords,
    this.succeeded,
    this.message,
    this.error,
    this.locations,
    this.measurements,
    this.types,
  });

  int totalRecords;
  bool succeeded;
  String message;
  String error;
  List<Location> locations;
  List<String> measurements;
  List<String> types;
}

class Location {
  Location({
    this.id,
    this.name,
    this.type,
    this.measurements,
    this.about,
    this.imageName,
    this.characters,
    this.placeOfBirthCharacters,
  });

  String id;
  String name;
  String type;
  String measurements;
  String about;
  String imageName;
  List<dynamic> characters;
  List<dynamic> placeOfBirthCharacters;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        measurements: json["measurements"],
        about: json["about"],
        imageName: json["imageName"],
        characters: List<dynamic>.from(json["characters"].map((x) => x)),
        placeOfBirthCharacters: List<dynamic>.from(json["placeOfBirthCharacters"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "measurements": measurements,
        "about": about,
        "imageName": imageName,
        "characters": List<dynamic>.from(characters.map((x) => x)),
        "placeOfBirthCharacters": List<dynamic>.from(placeOfBirthCharacters.map((x) => x)),
      };
}
