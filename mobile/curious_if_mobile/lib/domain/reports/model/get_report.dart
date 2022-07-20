import 'dart:convert';

import 'package:curious_if_mobile/domain/reports/model/get_report_comment.dart';
import 'package:curious_if_mobile/domain/reports/model/get_report_post.dart';

class GetReport {
  final String id;
  final String content;
  final String type;
  final String postId;
  final GetReportPost post;
  final String? commentId;
  final GetReportComment? comment;
  GetReport({
    required this.id,
    required this.content,
    required this.type,
    required this.postId,
    required this.post,
    this.commentId,
    this.comment,
  });

  GetReport copyWith({
    String? id,
    String? content,
    String? type,
    String? postId,
    GetReportPost? post,
    String? commentId,
    GetReportComment? comment,
  }) {
    return GetReport(
      id: id ?? this.id,
      content: content ?? this.content,
      type: type ?? this.type,
      postId: postId ?? this.postId,
      post: post ?? this.post,
      commentId: commentId ?? this.commentId,
      comment: comment ?? this.comment,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'type': type,
      'postId': postId,
      'post': post.toMap(),
      'commentId': commentId,
      'comment': comment?.toMap(),
    };
  }

  factory GetReport.fromMap(Map<String, dynamic> map) {
    return GetReport(
      id: map['id'] ?? '',
      content: map['content'] ?? '',
      type: map['type'] ?? '',
      postId: map['postId'] ?? '',
      post: GetReportPost.fromMap(map['post']),
      commentId: map['commentId'],
      comment: map['comment'] != null
          ? GetReportComment.fromMap(map['comment'])
          : null,
    );
  }

  static List<GetReport> fromJsonList(String source) {
    List getReportMap = json.decode(source);
    List<GetReport> getReport = [];
    for (Map<String, dynamic> map in getReportMap) {
      getReport.add(GetReport.fromMap(map));
    }
    return getReport;
  }

  String toJson() => json.encode(toMap());

  factory GetReport.fromJson(String source) =>
      GetReport.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GetReport(id: $id, content: $content, type: $type, postId: $postId, post: $post, commentId: $commentId, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetReport &&
        other.id == id &&
        other.content == content &&
        other.type == type &&
        other.postId == postId &&
        other.post == post &&
        other.commentId == commentId &&
        other.comment == comment;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        content.hashCode ^
        type.hashCode ^
        postId.hashCode ^
        post.hashCode ^
        commentId.hashCode ^
        comment.hashCode;
  }
}
