import 'dart:convert';

class CarModelModel {
  final int id;
  final String name;
  final dynamic properties;
  CarModelModel({
    required this.id,
    required this.name,
    required this.properties,
  });

  CarModelModel copyWith({
    int? id,
    String? name,
    dynamic properties,
  }) {
    return CarModelModel(
      id: id ?? this.id,
      name: name ?? this.name,
      properties: properties ?? this.properties,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'properties': properties});

    return result;
  }

  factory CarModelModel.fromMap(Map<dynamic, dynamic> map) {
    return CarModelModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      properties: map['properties'] ?? null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CarModelModel.fromJson(String source) => CarModelModel.fromMap(json.decode(source));

  @override
  String toString() => 'CarModelModel(id: $id, name: $name, properties: $properties)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CarModelModel && other.id == id && other.name == name && other.properties == properties;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ properties.hashCode;
}
