import 'package:meta/meta.dart';
import 'package:milestone/src/models/video.dart';

@immutable
class Topic {
  final int id;
  final String image;
  final String name;
  final String description;
  final List<Video> videos;

  Topic({this.id, this.image, this.name, this.description, this.videos});

  Topic copyWith(Map<String, dynamic> json) {
    return Topic(
      id: json["id"] ?? this.id,
      image: json["image"] ?? this.image,
      name: json["name"] ?? this.name,
      description: json["description"] ?? this.description,
      videos: json["videos"] ?? this.videos,
    );
  }

  Topic.fromMap(Map<String, dynamic> json)
      : id = json != null ? json["id"] : null,
        image = json != null ? json["image"] : null,
        name = json != null ? json["name"] : null,
        description = json != null ? json["description"] : null,
        videos = json != null ? Video.fromList(json["videos"]) : List<Video>();

  static fromList(List topics) {
    List<Topic> topicList = List<Topic>();

    for (Map topic in topics) {
      topicList.add(Topic.fromMap(topic));
    }

    return topicList;
  }
}
