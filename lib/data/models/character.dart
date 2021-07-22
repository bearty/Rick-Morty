import 'dart:convert';

// To parse this JSON data, do
//
//     final character = characterFromJson(jsonString);

Character characterNewFromJson(String str) => Character.fromJson(json.decode(str));

String characterNewToJson(Character data) => json.encode(data.toJson());

class Character {
  Character({
    this.id,
    this.firstName,
    this.lastName,
    this.fullName,
    this.status,
    this.about,
    this.gender,
    this.race,
    this.imageName,
    this.placeOfBirthId,
    this.placeOfBirth,
    this.location,
    this.locationId,
    this.episodes,
  });

  String id;
  String firstName;
  String lastName;
  String fullName;
  int status;
  String about;
  int gender;
  String race;
  String imageName;
  String placeOfBirthId;
  String placeOfBirth;
  String location;
  String locationId;
  List<dynamic> episodes;

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      fullName: json["fullName"],
      status: json["status"],
      about: json["about"],
      gender: json["gender"],
      race: json["race"],
      imageName: json["imageName"],
      placeOfBirthId: json["placeOfBirthId"],
      placeOfBirth: json["placeOfBirth"],
      location: json["location"],
      locationId: json["locationId"],
      episodes: json['episodes'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "fullName": fullName,
        "status": status,
        "about": about,
        "gender": gender,
        "race": race,
        "imageName": imageName,
        "placeOfBirthId": placeOfBirthId,
        "placeOfBirth": placeOfBirth,
        "location": location,
        "locationId": locationId,
        "episodes": episodes,
      };
}
