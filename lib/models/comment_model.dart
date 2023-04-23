import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yolustunde_mobile/models/user/user_model.dart';

class CommentModel {
  final int id;
  final int rating;
  final String comment;
  final String created_at;
  final String created_at_humans;
  final UserModel userModel;
  final String full_name;
  final List<CommentAnswerModel> answers;
  CommentModel({
    required this.id,
    required this.rating,
    required this.comment,
    required this.created_at,
    required this.created_at_humans,
    required this.userModel,
    required this.full_name,
    required this.answers,
  });

  CommentModel copyWith({
    int? id,
    int? rating,
    String? comment,
    String? created_at,
    String? created_at_humans,
    UserModel? userModel,
    String? full_name,
    List<CommentAnswerModel>? answers,
  }) {
    return CommentModel(
      id: id ?? this.id,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      created_at: created_at ?? this.created_at,
      created_at_humans: created_at_humans ?? this.created_at_humans,
      userModel: userModel ?? this.userModel,
      full_name: full_name ?? this.full_name,
      answers: answers ?? this.answers,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'rating': rating});
    result.addAll({'comment': comment});
    result.addAll({'created_at': created_at});
    result.addAll({'created_at_humans': created_at_humans});
    result.addAll({'userModel': userModel.toMap()});
    result.addAll({'full_name': full_name});
    result.addAll({'answers': answers.map((x) => x.toMap()).toList()});

    return result;
  }

  factory CommentModel.fromMap(Map<dynamic, dynamic> map) {
    return CommentModel(
      id: map['id']?.toInt() ?? 0,
      rating: map['rating']?.toInt() ?? 0,
      comment: map['comment'] ?? '',
      created_at: map['created_at'] ?? '',
      created_at_humans: map['created_at_humans'] ?? '',
      userModel: UserModel.fromMap(map['user']),
      full_name: map['full_name'] ?? '',
      answers: List<CommentAnswerModel>.from(map['answers']?.map((x) => CommentAnswerModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) => CommentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CommentModel(id: $id, rating: $rating, comment: $comment, created_at: $created_at, created_at_humans: $created_at_humans, userModel: $userModel, full_name: $full_name, answers: $answers)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CommentModel &&
        other.id == id &&
        other.rating == rating &&
        other.comment == comment &&
        other.created_at == created_at &&
        other.created_at_humans == created_at_humans &&
        other.userModel == userModel &&
        other.full_name == full_name &&
        listEquals(other.answers, answers);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        rating.hashCode ^
        comment.hashCode ^
        created_at.hashCode ^
        created_at_humans.hashCode ^
        userModel.hashCode ^
        full_name.hashCode ^
        answers.hashCode;
  }
}

class CommentAnswerModel {
  final int id;
  final int rating;
  final String comment;
  final String created_at;
  final String created_at_humans;
  final UserModel userModel;
  final String body;
  CommentAnswerModel({
    required this.id,
    required this.rating,
    required this.comment,
    required this.created_at,
    required this.created_at_humans,
    required this.userModel,
    required this.body,
  });

  CommentAnswerModel copyWith({
    int? id,
    int? rating,
    String? comment,
    String? created_at,
    String? created_at_humans,
    UserModel? userModel,
    String? body,
  }) {
    return CommentAnswerModel(
      id: id ?? this.id,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      created_at: created_at ?? this.created_at,
      created_at_humans: created_at_humans ?? this.created_at_humans,
      userModel: userModel ?? this.userModel,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'rating': rating});
    result.addAll({'comment': comment});
    result.addAll({'created_at': created_at});
    result.addAll({'created_at_humans': created_at_humans});
    result.addAll({'userModel': userModel.toMap()});
    result.addAll({'body': body});

    return result;
  }

  factory CommentAnswerModel.fromMap(Map<dynamic, dynamic> map) {
    return CommentAnswerModel(
      id: map['id']?.toInt() ?? 0,
      rating: map['rating']?.toInt() ?? 0,
      comment: map['comment'] ?? '',
      created_at: map['created_at'] ?? '',
      created_at_humans: map['created_at_humans'] ?? '',
      userModel: UserModel.fromMap(map['user']),
      body: map['body'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentAnswerModel.fromJson(String source) => CommentAnswerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CommentAnswerModel(id: $id, rating: $rating, comment: $comment, created_at: $created_at, created_at_humans: $created_at_humans, userModel: $userModel, body: $body)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CommentAnswerModel &&
        other.id == id &&
        other.rating == rating &&
        other.comment == comment &&
        other.created_at == created_at &&
        other.created_at_humans == created_at_humans &&
        other.userModel == userModel &&
        other.body == body;
  }

  @override
  int get hashCode {
    return id.hashCode ^ rating.hashCode ^ comment.hashCode ^ created_at.hashCode ^ created_at_humans.hashCode ^ userModel.hashCode ^ body.hashCode;
  }
}
