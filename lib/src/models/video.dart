import 'package:meta/meta.dart';

@immutable
class Video {
  final int id;
  final String thumbnail;
  final String title;
  final String description;
  final String url;

  Video({this.id, this.thumbnail, this.title, this.description, this.url});

  Video copyWith(Map<String, dynamic> json) {
    return Video(
      id: json["id"] ?? this.id,
      thumbnail: json["thumbnail"] ?? this.thumbnail,
      title: json["title"] ?? this.title,
      description: json["description"] ?? this.description,
      url: json["url"] ?? this.url,
    );
  }

  Video.fromMap(Map<String, dynamic> json)
      : id = json != null ? json["id"] : null,
        thumbnail = json != null ? json["thumbnail"] : null,
        title = json != null ? json["title"] : null,
        description = json != null ? json["description"] : null,
        url = json != null ? json["url"] : null;

  static fromList(List videos) {
    List<Video> videoList = List<Video>();

    for (Map video in videos) {
      videoList.add(Video.fromMap(video));
    }

    return videoList;
  }
}
