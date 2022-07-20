import 'dart:convert';

class GetReportPost {
  final String content;
  final String to;
  final int numberOfLikes;
  final int postNumber;
  GetReportPost({
    required this.content,
    required this.to,
    required this.numberOfLikes,
    required this.postNumber,
  });

  GetReportPost copyWith({
    String? content,
    String? to,
    int? numberOfLikes,
    int? postNumber,
  }) {
    return GetReportPost(
      content: content ?? this.content,
      to: to ?? this.to,
      numberOfLikes: numberOfLikes ?? this.numberOfLikes,
      postNumber: postNumber ?? this.postNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'to': to,
      'numberOfLikes': numberOfLikes,
      'postNumber': postNumber,
    };
  }

  factory GetReportPost.fromMap(Map<String, dynamic> map) {
    return GetReportPost(
      content: map['content'] ?? '',
      to: map['to'] ?? '',
      numberOfLikes: map['numberOfLikes']?.toInt() ?? 0,
      postNumber: map['postNumber']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetReportPost.fromJson(String source) =>
      GetReportPost.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GetReportPost(content: $content, to: $to, numberOfLikes: $numberOfLikes, postNumber: $postNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetReportPost &&
        other.content == content &&
        other.to == to &&
        other.numberOfLikes == numberOfLikes &&
        other.postNumber == postNumber;
  }

  @override
  int get hashCode {
    return content.hashCode ^
        to.hashCode ^
        numberOfLikes.hashCode ^
        postNumber.hashCode;
  }
}
