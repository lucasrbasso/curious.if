import 'dart:convert';

class ReportComment {
  final String postId;
  final String commentId;
  final String content;
  final String type;
  ReportComment({
    required this.postId,
    required this.commentId,
    required this.content,
    this.type = "COMMENT",
  });

  ReportComment copyWith({
    String? postId,
    String? commentId,
    String? content,
    String? type,
  }) {
    return ReportComment(
      postId: postId ?? this.postId,
      commentId: commentId ?? this.commentId,
      content: content ?? this.content,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'commentId': commentId,
      'content': content,
      'type': type,
    };
  }

  factory ReportComment.fromMap(Map<String, dynamic> map) {
    return ReportComment(
      postId: map['postId'] ?? '',
      commentId: map['commentId'] ?? '',
      content: map['content'] ?? '',
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportComment.fromJson(String source) =>
      ReportComment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReportComment(postId: $postId, commentId: $commentId, content: $content, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReportComment &&
        other.postId == postId &&
        other.commentId == commentId &&
        other.content == content &&
        other.type == type;
  }

  @override
  int get hashCode {
    return postId.hashCode ^
        commentId.hashCode ^
        content.hashCode ^
        type.hashCode;
  }
}
