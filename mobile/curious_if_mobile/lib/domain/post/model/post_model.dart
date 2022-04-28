import 'dart:convert';

class PostModel {
  final String id;
  final String body;
  final String forPeople;
  final DateTime createdAt;
  PostModel({
    required this.id,
    required this.body,
    required this.forPeople,
    required this.createdAt,
  });

  PostModel copyWith({
    String? id,
    String? body,
    String? forPeople,
    DateTime? createdAt,
  }) {
    return PostModel(
      id: id ?? this.id,
      body: body ?? this.body,
      forPeople: forPeople ?? this.forPeople,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'body': body});
    result.addAll({'forPeople': forPeople});
    result.addAll({'createdAt': createdAt.millisecondsSinceEpoch});

    return result;
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] ?? '',
      body: map['body'] ?? '',
      forPeople: map['forPeople'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PostModel(id: $id, body: $body, forPeople: $forPeople, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostModel &&
        other.id == id &&
        other.body == body &&
        other.forPeople == forPeople &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        body.hashCode ^
        forPeople.hashCode ^
        createdAt.hashCode;
  }
}
