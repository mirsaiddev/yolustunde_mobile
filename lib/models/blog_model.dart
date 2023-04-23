import 'dart:convert';

class BlogModel {
  final String title;
  final String body;
  final String created_at;
  final String diffForHumans;
  BlogModel({
    required this.title,
    required this.body,
    required this.created_at,
    required this.diffForHumans,
  });

  BlogModel copyWith({
    String? title,
    String? body,
    String? created_at,
    String? diffForHumans,
  }) {
    return BlogModel(
      title: title ?? this.title,
      body: body ?? this.body,
      created_at: created_at ?? this.created_at,
      diffForHumans: diffForHumans ?? this.diffForHumans,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'body': body});
    result.addAll({'created_at': created_at});
    result.addAll({'diffForHumans': diffForHumans});

    return result;
  }

  factory BlogModel.fromMap(Map<dynamic, dynamic> map) {
    return BlogModel(
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      created_at: map['created_at'] ?? '',
      diffForHumans: map['diffForHumans'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BlogModel.fromJson(String source) => BlogModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BlogModel(title: $title, body: $body, created_at: $created_at, diffForHumans: $diffForHumans)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BlogModel && other.title == title && other.body == body && other.created_at == created_at && other.diffForHumans == diffForHumans;
  }

  @override
  int get hashCode {
    return title.hashCode ^ body.hashCode ^ created_at.hashCode ^ diffForHumans.hashCode;
  }
}
