import 'dart:convert';

class CompanyModel {
  final int id;
  final String title;
  final String image;
  final String description;
  final int averageRating;
  final int countRating;
  final String type;
  final double latitude;
  final double longitude;
  CompanyModel({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.averageRating,
    required this.countRating,
    required this.type,
    required this.latitude,
    required this.longitude,
  });

  CompanyModel copyWith({
    int? id,
    String? title,
    String? image,
    String? description,
    int? averageRating,
    int? countRating,
    String? type,
    double? latitude,
    double? longitude,
  }) {
    return CompanyModel(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      description: description ?? this.description,
      averageRating: averageRating ?? this.averageRating,
      countRating: countRating ?? this.countRating,
      type: type ?? this.type,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'image': image});
    result.addAll({'description': description});
    result.addAll({'averageRating': averageRating});
    result.addAll({'countRating': countRating});
    result.addAll({'type': type});
    result.addAll({'latitude': latitude});
    result.addAll({'longitude': longitude});

    return result;
  }

  factory CompanyModel.fromMap(Map<dynamic, dynamic> map) {
    return CompanyModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      description: map['description'] ?? '',
      averageRating: map['averageRating']?.toInt() ?? 0,
      countRating: map['countRating']?.toInt() ?? 0,
      type: map['type'] ?? '',
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyModel.fromJson(String source) => CompanyModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CompanyModel(id: $id, title: $title, image: $image, description: $description, averageRating: $averageRating, countRating: $countRating, type: $type, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CompanyModel &&
        other.id == id &&
        other.title == title &&
        other.image == image &&
        other.description == description &&
        other.averageRating == averageRating &&
        other.countRating == countRating &&
        other.type == type &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        image.hashCode ^
        description.hashCode ^
        averageRating.hashCode ^
        countRating.hashCode ^
        type.hashCode ^
        latitude.hashCode ^
        longitude.hashCode;
  }
}
