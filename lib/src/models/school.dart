import 'package:meta/meta.dart';

@immutable
class School {
  final int id;
  final String name;
  final String location;

  School({this.id, this.name, this.location});

  School copyWith(Map<String, dynamic> json) {
    return School(
      id: json["id"] ?? this.id,
      name: json["name"] ?? this.name,
      location: json["location"] ?? this.location,
    );
  }

  School.fromJson(Map<String, dynamic> json)
      : id = json != null ? json["id"] : null,
        name = json != null ? json["name"] : null,
        location = json != null ? json["location"] : null;
}
