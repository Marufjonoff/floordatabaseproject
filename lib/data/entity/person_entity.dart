import 'package:floor/floor.dart';

@entity
class PersonEntity {
  @PrimaryKey(autoGenerate: false)
  final String createdAt;
  final String updatedAt;
  final String avatar;
  final String title;
  final String body;
  final String id;

  PersonEntity({
    required this.createdAt,
    required this.updatedAt,
    required this.avatar,
    required this.title,
    required this.body,
    required this.id,
  });

  factory PersonEntity.fromJson(Map<String, dynamic> json) => PersonEntity(
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    avatar: json["avatar"],
    title: json["title"],
    body: json["body"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "avatar": avatar,
    "title": title,
    "body": body,
    "id": id,
  };
}
