import 'dart:convert';

class PostManagementModel {
  final String id;
  final String content;
  final String forPeople;
  final DateTime createdAt;
  PostManagementModel({
    required this.id,
    required this.content,
    required this.forPeople,
    required this.createdAt,
  });

  PostManagementModel copyWith({
    String? id,
    String? content,
    String? forPeople,
    DateTime? createdAt,
  }) {
    return PostManagementModel(
      id: id ?? this.id,
      content: content ?? this.content,
      forPeople: forPeople ?? this.forPeople,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'forPeople': forPeople,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory PostManagementModel.fromMap(Map<String, dynamic> map) {
    print(map);
    return PostManagementModel(
      id: map['id'] ?? '',
      content: map['content'] ?? '',
      forPeople: map['to'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  factory PostManagementModel.mock() {
    return PostManagementModel(
      id: '',
      content: '',
      forPeople: '',
      createdAt: DateTime.now(),
    );
  }

  static List<PostManagementModel> fromJsonList(String source) {
    List postsMap = json.decode(source);
    List<PostManagementModel> posts = [];
    for (Map<String, dynamic> map in postsMap) {
      posts.add(PostManagementModel.fromMap(map));
    }
    return posts;
  }

  String toJson() => json.encode(toMap());

  factory PostManagementModel.fromJson(String source) =>
      PostManagementModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PostManagementModel(id: $id, content: $content, forPeople: $forPeople, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostManagementModel &&
        other.id == id &&
        other.content == content &&
        other.forPeople == forPeople &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        content.hashCode ^
        forPeople.hashCode ^
        createdAt.hashCode;
  }
}
