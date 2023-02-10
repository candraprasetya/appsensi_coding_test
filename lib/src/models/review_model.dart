part of 'models.dart';
// To parse this JSON data, do
//
//     final reviewModel = reviewModelFromMap(jsonString);

ReviewModel reviewModelFromMap(String str) =>
    ReviewModel.fromMap(json.decode(str));

String reviewModelToMap(ReviewModel data) => json.encode(data.toMap());

class ReviewModel {
  ReviewModel({
    this.author,
    this.authorDetails,
    this.content,
    this.createdAt,
    this.id,
    this.updatedAt,
    this.url,
  });

  final String? author;
  final AuthorDetails? authorDetails;
  final String? content;
  final DateTime? createdAt;
  final String? id;
  final DateTime? updatedAt;
  final String? url;

  factory ReviewModel.fromMap(Map<String, dynamic> json) => ReviewModel(
        author: json["author"] ?? '',
        authorDetails: AuthorDetails.fromMap(json["author_details"]),
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "author": author,
        "author_details": authorDetails!.toMap(),
        "content": content,
        "created_at": createdAt!.toIso8601String(),
        "id": id,
        "updated_at": updatedAt!.toIso8601String(),
        "url": url,
      };
}

class AuthorDetails {
  AuthorDetails({
    this.name,
    this.username,
    this.avatarPath,
    this.rating,
  });

  final String? name;
  final String? username;
  final String? avatarPath;
  final double? rating;

  factory AuthorDetails.fromMap(Map<String, dynamic> json) => AuthorDetails(
        name: json["name"] ?? '',
        username: json["username"] ?? '',
        avatarPath: json["avatar_path"] ??
            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
        rating: json["rating"] ?? 0.0,
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "username": username,
        "avatar_path": avatarPath,
        "rating": rating,
      };
}
