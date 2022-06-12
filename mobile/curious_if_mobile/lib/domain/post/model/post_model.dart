import 'dart:convert';

class PostModel {
  final String id;
  final int numberOfLikes;
  final bool isLiked;
  final String content;
  final String forPeople;
  final DateTime createdAt;
  PostModel({
    required this.id,
    required this.numberOfLikes,
    required this.isLiked,
    required this.content,
    required this.forPeople,
    required this.createdAt,
  });

  PostModel copyWith({
    String? id,
    int? numberOfLikes,
    bool? isLiked,
    String? content,
    String? forPeople,
    DateTime? createdAt,
  }) {
    return PostModel(
      id: id ?? this.id,
      numberOfLikes: numberOfLikes ?? this.numberOfLikes,
      isLiked: isLiked ?? this.isLiked,
      content: content ?? this.content,
      forPeople: forPeople ?? this.forPeople,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'numberOfLikes': numberOfLikes,
      'isLiked': isLiked,
      'content': content,
      'forPeople': forPeople,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] ?? '',
      numberOfLikes: map['numberOfLikes']?.toInt() ?? 0,
      isLiked: map['isLiked'] ?? false,
      content: map['content'] ?? '',
      forPeople: map['to'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  factory PostModel.mock() {
    return PostModel(
      id: '',
      content: '',
      forPeople: '',
      isLiked: false,
      numberOfLikes: 0,
      createdAt: DateTime.now(),
    );
  }

  static List<PostModel> fromJsonList(String source) {
    List postsMap = json.decode(source);
    List<PostModel> posts = [];
    for (Map<String, dynamic> map in postsMap) {
      posts.add(PostModel.fromMap(map));
    }
    return posts;
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PostModel(id: $id, numberOfLikes: $numberOfLikes, isLiked: $isLiked, content: $content, forPeople: $forPeople, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostModel &&
        other.id == id &&
        other.numberOfLikes == numberOfLikes &&
        other.isLiked == isLiked &&
        other.content == content &&
        other.forPeople == forPeople &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        numberOfLikes.hashCode ^
        isLiked.hashCode ^
        content.hashCode ^
        forPeople.hashCode ^
        createdAt.hashCode;
  }
}
