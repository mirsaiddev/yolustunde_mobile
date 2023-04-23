import 'dart:convert';

class ForumModel {
  final int id;
  final int answer_counts;
  final String title;
  final String message;
  final String type;
  final String created_at;
  final String created_at_humans;
  final User user;
  ForumModel({
    required this.id,
    required this.answer_counts,
    required this.title,
    required this.message,
    required this.type,
    required this.created_at,
    required this.created_at_humans,
    required this.user,
  });

  ForumModel copyWith({
    int? id,
    int? answer_counts,
    String? title,
    String? message,
    String? type,
    String? created_at,
    String? created_at_humans,
    User? user,
  }) {
    return ForumModel(
      id: id ?? this.id,
      answer_counts: answer_counts ?? this.answer_counts,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      created_at: created_at ?? this.created_at,
      created_at_humans: created_at_humans ?? this.created_at_humans,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'answer_counts': answer_counts});
    result.addAll({'title': title});
    result.addAll({'message': message});
    result.addAll({'type': type});
    result.addAll({'created_at': created_at});
    result.addAll({'created_at_humans': created_at_humans});
    result.addAll({'user': user.toMap()});

    return result;
  }

  factory ForumModel.fromMap(Map<dynamic, dynamic> map) {
    return ForumModel(
      id: map['id']?.toInt() ?? 0,
      answer_counts: map['answer_counts']?.toInt() ?? 0,
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      type: map['type'] ?? '',
      created_at: map['created_at'] ?? '',
      created_at_humans: map['created_at_humans'] ?? '',
      user: User.fromMap(map['user']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ForumModel.fromJson(String source) => ForumModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ForumModel(id: $id, answer_counts: $answer_counts, title: $title, message: $message, type: $type, created_at: $created_at, created_at_humans: $created_at_humans, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ForumModel &&
        other.id == id &&
        other.answer_counts == answer_counts &&
        other.title == title &&
        other.message == message &&
        other.type == type &&
        other.created_at == created_at &&
        other.created_at_humans == created_at_humans &&
        other.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        answer_counts.hashCode ^
        title.hashCode ^
        message.hashCode ^
        type.hashCode ^
        created_at.hashCode ^
        created_at_humans.hashCode ^
        user.hashCode;
  }
}

class User {
  final int id;
  final String first_name;
  final String last_name;
  final String email;
  final String phone;
  User({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.phone,
  });

  User copyWith({
    int? id,
    String? first_name,
    String? last_name,
    String? email,
    String? phone,
  }) {
    return User(
      id: id ?? this.id,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'first_name': first_name});
    result.addAll({'last_name': last_name});
    result.addAll({'email': email});
    result.addAll({'phone': phone});

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt() ?? 0,
      first_name: map['first_name'] ?? '',
      last_name: map['last_name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, first_name: $first_name, last_name: $last_name, email: $email, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.id == id && other.first_name == first_name && other.last_name == last_name && other.email == email && other.phone == phone;
  }

  @override
  int get hashCode {
    return id.hashCode ^ first_name.hashCode ^ last_name.hashCode ^ email.hashCode ^ phone.hashCode;
  }
}
