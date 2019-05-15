import 'package:meta/meta.dart';
import 'package:milestone/src/models/topic.dart';

@immutable
class Category {
  final int id;
  final String name;
  final String image;
  final List<Topic> topics;

  Category({
    this.id,
    this.name,
    this.image,
    this.topics,
  });

  Category copyWith(Map<String, dynamic> json) {
    return Category(
      id: json["id"] ?? this.id,
      name: json["name"] ?? this.name,
      image: json["image"] ?? this.image,
      topics: json["topics"] ?? this.topics,
    );
  }

  Category.fromMap(Map<String, dynamic> json)
      : id = json != null ? json["id"] : null,
        name = json != null ? json["name"] : null,
        image = json != null ? json["image"] : null,
        topics = json != null ? Topic.fromList(json["topics"]) : List<Topic>();

  static fromList(List categories) {
    List<Category> categoryList = List<Category>();

    for (Map category in categories) {
      categoryList.add(Category.fromMap(category));
    }

    return categoryList;
  }
}
