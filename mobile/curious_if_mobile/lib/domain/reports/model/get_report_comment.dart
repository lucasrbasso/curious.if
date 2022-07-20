import 'dart:convert';

class GetReportComment {
  final String content;
  final int numberOfLikes;
  GetReportComment({
    required this.content,
    required this.numberOfLikes,
  });

  GetReportComment copyWith({
    String? content,
    int? numberOfLikes,
  }) {
    return GetReportComment(
      content: content ?? this.content,
      numberOfLikes: numberOfLikes ?? this.numberOfLikes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'numberOfLikes': numberOfLikes,
    };
  }

  factory GetReportComment.fromMap(Map<String, dynamic> map) {
    return GetReportComment(
      content: map['content'] ?? '',
      numberOfLikes: map['numberOfLikes']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetReportComment.fromJson(String source) =>
      GetReportComment.fromMap(json.decode(source));

  @override
  String toString() =>
      'GetReportComment(content: $content, numberOfLikes: $numberOfLikes)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetReportComment &&
        other.content == content &&
        other.numberOfLikes == numberOfLikes;
  }

  @override
  int get hashCode => content.hashCode ^ numberOfLikes.hashCode;
}
