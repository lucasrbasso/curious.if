import 'dart:convert';

class PostModel {
  final String id;
  final int numberPost;
  final int numberOfLikes;
  final int numberOfComments;
  final bool isLiked;
  final String content;
  final String forPeople;
  final DateTime createdAt;
  PostModel({
    required this.id,
    required this.numberPost,
    required this.numberOfLikes,
    required this.numberOfComments,
    required this.isLiked,
    required this.content,
    required this.forPeople,
    required this.createdAt,
  });

  PostModel copyWith({
    String? id,
    int? numberOfLikes,
    int? numberPost,
    int? numberOfComments,
    bool? isLiked,
    String? content,
    String? forPeople,
    DateTime? createdAt,
  }) {
    return PostModel(
      id: id ?? this.id,
      numberPost: numberPost ?? this.numberPost,
      numberOfLikes: numberOfLikes ?? this.numberOfLikes,
      numberOfComments: numberOfComments ?? this.numberOfComments,
      isLiked: isLiked ?? this.isLiked,
      content: content ?? this.content,
      forPeople: forPeople ?? this.forPeople,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'numberPost': numberPost,
      'numberOfLikes': numberOfLikes,
      'numberOfComments': numberOfComments,
      'isLiked': isLiked,
      'content': content,
      'forPeople': forPeople,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] ?? '',
      numberPost: map['postNumber']?.toInt() ?? 0,
      numberOfLikes: map['numberOfLikes']?.toInt() ?? 0,
      numberOfComments: map['numberOfComments']?.toInt() ?? 0,
      isLiked: map['isLiked'] ?? false,
      content: map['content'] ?? '',
      forPeople: map['to'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  factory PostModel.mock() {
    return PostModel(
      id: '',
      numberPost: 0,
      content: '',
      forPeople: '',
      isLiked: false,
      numberOfLikes: 0,
      numberOfComments: 0,
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
    return 'PostModel(id: $id, numberPost: $numberPost, numberOfComments: $numberOfComments, numberOfLikes: $numberOfLikes,  isLiked: $isLiked, content: $content, forPeople: $forPeople, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostModel &&
        other.id == id &&
        other.numberPost == numberPost &&
        other.numberOfLikes == numberOfLikes &&
        other.numberOfComments == numberOfComments &&
        other.isLiked == isLiked &&
        other.content == content &&
        other.forPeople == forPeople &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        numberPost.hashCode ^
        numberOfLikes.hashCode ^
        numberOfComments.hashCode ^
        isLiked.hashCode ^
        content.hashCode ^
        forPeople.hashCode ^
        createdAt.hashCode;
  }
}
