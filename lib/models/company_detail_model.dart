import 'dart:convert';

class CompanyDetailModel {
  final int id;
  final String title;
  final String image;
  final String description;
  final int averageRating;
  final int countRating;
  final String type;
  final double latitude;
  final double longitude;
  final List<Service> services;
  CompanyDetailModel({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.averageRating,
    required this.countRating,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.services,
  });

  CompanyDetailModel copyWith({
    int? id,
    String? title,
    String? image,
    String? description,
    int? averageRating,
    int? countRating,
    String? type,
    double? latitude,
    double? longitude,
    List<Service>? services,
  }) {
    return CompanyDetailModel(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      description: description ?? this.description,
      averageRating: averageRating ?? this.averageRating,
      countRating: countRating ?? this.countRating,
      type: type ?? this.type,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      services: services ?? this.services,
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
    result.addAll({'services': services.map((x) => x.toMap()).toList()});

    return result;
  }

  factory CompanyDetailModel.fromMap(Map<dynamic, dynamic> map) {
    return CompanyDetailModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      description: map['description'] ?? '',
      averageRating: map['averageRating']?.toInt() ?? 0,
      countRating: map['countRating']?.toInt() ?? 0,
      type: map['type'] ?? '',
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      services: map['services'] != null ? List<Service>.from(map['services'].map((x) => Service.fromMap(x))) : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyDetailModel.fromJson(String source) => CompanyDetailModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CompanyDetailModel(id: $id, title: $title, image: $image, description: $description, averageRating: $averageRating, countRating: $countRating, type: $type, latitude: $latitude, longitude: $longitude, services: $services)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CompanyDetailModel &&
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
        longitude.hashCode ^
        services.hashCode;
  }
}

class Service {
  final int id;
  final String service;
  Service({
    required this.id,
    required this.service,
  });

  Service copyWith({
    int? id,
    String? service,
  }) {
    return Service(
      id: id ?? this.id,
      service: service ?? this.service,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'service': service});

    return result;
  }

  factory Service.fromMap(Map<dynamic, dynamic> map) {
    return Service(
      id: map['id']?.toInt() ?? 0,
      service: map['service'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Service.fromJson(String source) => Service.fromMap(json.decode(source));

  @override
  String toString() => 'Service(id: $id, service: $service)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Service && other.id == id && other.service == service;
  }

  @override
  int get hashCode => id.hashCode ^ service.hashCode;
}
