import 'dart:convert';

// "id": "d6fbfb13-3e3c-461e-98d6-813f9d767bd1",
// "content": "TEste",
// "authorId": "289f785d-04dd-4a57-b176-9cf75832b5da",
// "postId": "da554f66-2a0a-46cd-a8f1-907e52a2fc7f",
// "createdAt": "2022-06-16T23:39:51.044Z",
// "updatedAt": "2022-06-16T23:39:51.044Z"

class CommentModel {
  final String id;
  final String authorName;
  final bool isOwner;
  final int numberOfLikes;
  final bool isLiked;
  final String content;
  final String authorId;
  final String postId;
  final DateTime createdAt;
  final DateTime updatedAt;
  CommentModel({
    required this.id,
    required this.isOwner,
    required this.content,
    required this.numberOfLikes,
    required this.isLiked,
    required this.authorId,
    required this.authorName,
    required this.postId,
    required this.createdAt,
    required this.updatedAt,
  });

  CommentModel copyWith({
    String? id,
    String? content,
    String? authorId,
    int? numberOfLikes,
    bool? isLiked,
    String? authorName,
    String? postId,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isOwner,
  }) {
    return CommentModel(
      id: id ?? this.id,
      numberOfLikes: numberOfLikes ?? this.numberOfLikes,
      isLiked: isLiked ?? this.isLiked,
      content: content ?? this.content,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      postId: postId ?? this.postId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isOwner: isOwner ?? this.isOwner,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'numberOfLikes': numberOfLikes,
      'isLiked': isLiked,
      'content': content,
      'authorId': authorId,
      'authorName': authorName,
      'postId': postId,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'isOwner': isOwner,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'] ?? '',
      numberOfLikes: map['numberOfLikes']?.toInt() ?? 0,
      isLiked: map['isLiked'] ?? false,
      content: map['content'] ?? '',
      authorId: map['authorId'] ?? '',
      authorName: map['authorName'] ?? '',
      postId: map['postId'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      isOwner: map['isOwner'] ?? false,
    );
  }

  static List<CommentModel> fromJsonList(String source) {
    List commentsMap = json.decode(source);
    List<CommentModel> comments = [];
    for (Map<String, dynamic> map in commentsMap) {
      comments.add(CommentModel.fromMap(map));
    }
    return comments;
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CommentModel(id: $id,numberOfLikes: $numberOfLikes, isLiked: $isLiked, authorName: $authorName, isOwner: $isOwner content: $content, authorId: $authorId, postId: $postId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CommentModel &&
        other.id == id &&
        other.numberOfLikes == numberOfLikes &&
        other.isLiked == isLiked &&
        other.content == content &&
        other.authorName == authorName &&
        other.authorId == authorId &&
        other.isOwner == isOwner &&
        other.postId == postId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        numberOfLikes.hashCode ^
        isLiked.hashCode ^
        content.hashCode ^
        isOwner.hashCode ^
        authorName.hashCode ^
        authorId.hashCode ^
        postId.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
