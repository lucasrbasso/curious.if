import 'dart:convert';

class ReportPost {
  final String postId;
  final String content;
  final String type;
  ReportPost({
    required this.postId,
    required this.content,
    this.type = "POST",
  });

  ReportPost copyWith({
    String? postId,
    String? content,
    String? type,
  }) {
    return ReportPost(
      postId: postId ?? this.postId,
      content: content ?? this.content,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'content': content,
      'type': type,
    };
  }

  factory ReportPost.fromMap(Map<String, dynamic> map) {
    return ReportPost(
      postId: map['postId'] ?? '',
      content: map['content'] ?? '',
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportPost.fromJson(String source) =>
      ReportPost.fromMap(json.decode(source));

  @override
  String toString() =>
      'ReportPost(postId: $postId, content: $content, type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReportPost &&
        other.postId == postId &&
        other.content == content &&
        other.type == type;
  }

  @override
  int get hashCode => postId.hashCode ^ content.hashCode ^ type.hashCode;
}
