import 'dart:convert';

class BrandModel {
  final int id;
  final String name;
  BrandModel({
    required this.id,
    required this.name,
  });

  BrandModel copyWith({
    int? id,
    String? name,
  }) {
    return BrandModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});

    return result;
  }

  factory BrandModel.fromMap(Map<dynamic, dynamic> map) {
    return BrandModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BrandModel.fromJson(String source) => BrandModel.fromMap(json.decode(source));

  @override
  String toString() => 'BrandModel(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BrandModel && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
