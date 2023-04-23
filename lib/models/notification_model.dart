import 'dart:convert';

class NotificationModel {
  final String id;
  final Extras extras;
  final String createdAt;
  final String diffForHumans;
  final bool readed;

  NotificationModel({
    required this.id,
    required this.extras,
    required this.createdAt,
    required this.diffForHumans,
    required this.readed,
  });

  NotificationModel copyWith({
    String? id,
    Extras? extras,
    String? created_at,
    String? diffForHumans,
    bool? readed,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      extras: extras ?? this.extras,
      createdAt: created_at ?? this.createdAt,
      diffForHumans: diffForHumans ?? this.diffForHumans,
      readed: readed ?? this.readed,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'extras': extras.toMap()});
    result.addAll({'created_at': createdAt});
    result.addAll({'diffForHumans': diffForHumans});
    result.addAll({'readed': readed});

    return result;
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] ?? '',
      extras: Extras.fromMap(map['extras']),
      createdAt: map['created_at'] ?? '',
      diffForHumans: map['diffForHumans'] ?? '',
      readed: map['readed'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) => NotificationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotificationModek(id: $id, extras: $extras, created_at: $createdAt, diffForHumans: $diffForHumans, readed: $readed)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationModel &&
        other.id == id &&
        other.extras == extras &&
        other.createdAt == createdAt &&
        other.diffForHumans == diffForHumans &&
        other.readed == readed;
  }

  @override
  int get hashCode {
    return id.hashCode ^ extras.hashCode ^ createdAt.hashCode ^ diffForHumans.hashCode ^ readed.hashCode;
  }
}

class Extras {
  final String type;
  final String title;
  final String? message;
  final int? notifiableId;
  Extras({
    required this.type,
    required this.title,
    this.message,
    this.notifiableId,
  });

  Extras copyWith({
    String? type,
    String? title,
    String? message,
    int? notifiable_id,
  }) {
    return Extras(
      type: type ?? this.type,
      title: title ?? this.title,
      message: message ?? this.message,
      notifiableId: notifiable_id ?? this.notifiableId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'type': type});
    result.addAll({'title': title});
    if (message != null) {
      result.addAll({'message': message});
    }
    if (notifiableId != null) {
      result.addAll({'notifiable_id': notifiableId});
    }

    return result;
  }

  factory Extras.fromMap(Map<String, dynamic> map) {
    return Extras(
      type: map['type'] ?? '',
      title: map['title'] ?? '',
      message: map['message'].toString(),
      notifiableId: map['notifiable_id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Extras.fromJson(String source) => Extras.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Extras(type: $type, title: $title, message: $message, notifiable_id: $notifiableId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Extras && other.type == type && other.title == title && other.message == message && other.notifiableId == notifiableId;
  }

  @override
  int get hashCode {
    return type.hashCode ^ title.hashCode ^ message.hashCode ^ notifiableId.hashCode;
  }
}
