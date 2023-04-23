import 'dart:convert';

import 'package:flutter/foundation.dart';

class CarModel {
  final int id;
  final String plaka;
  final String model;
  final String brand;
  final int year;
  final String color;
  final List infos;
  CarModel({
    required this.id,
    required this.plaka,
    required this.model,
    required this.brand,
    required this.year,
    required this.color,
    required this.infos,
  });

  CarModel copyWith({
    int? id,
    String? plaka,
    String? model,
    String? brand,
    int? year,
    String? color,
    List? infos,
  }) {
    return CarModel(
      id: id ?? this.id,
      plaka: plaka ?? this.plaka,
      model: model ?? this.model,
      brand: brand ?? this.brand,
      year: year ?? this.year,
      color: color ?? this.color,
      infos: infos ?? this.infos,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'plaka': plaka});
    result.addAll({'model': model});
    result.addAll({'brand': brand});
    result.addAll({'year': year});
    result.addAll({'color': color});
    result.addAll({'infos': infos});

    return result;
  }

  factory CarModel.fromMap(Map<dynamic, dynamic> map) {
    return CarModel(
      id: map['id']?.toInt() ?? 0,
      plaka: map['plaka'] ?? '',
      model: map['model'] ?? '',
      brand: map['brand'] ?? '',
      year: map['year']?.toInt() ?? 0,
      color: map['color'] ?? '',
      infos: List.from(map['infos']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CarModel.fromJson(String source) => CarModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CarModel(id: $id, plaka: $plaka, model: $model, brand: $brand, year: $year, color: $color, infos: $infos)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CarModel &&
        other.id == id &&
        other.plaka == plaka &&
        other.model == model &&
        other.brand == brand &&
        other.year == year &&
        other.color == color &&
        listEquals(other.infos, infos);
  }

  @override
  int get hashCode {
    return id.hashCode ^ plaka.hashCode ^ model.hashCode ^ brand.hashCode ^ year.hashCode ^ color.hashCode ^ infos.hashCode;
  }
}
