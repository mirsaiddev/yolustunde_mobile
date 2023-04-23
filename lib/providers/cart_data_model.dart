import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yolustunde_mobile/models/cart_product_model.dart';

class CartDataModel {
  final int id;
  final String oid;
  final int status;
  final DateTime createdAt;
  final String createdAtHumans;
  final int countProducts;
  final int total;
  final List<CartProductModel> products;
  CartDataModel({
    required this.id,
    required this.oid,
    required this.status,
    required this.createdAt,
    required this.createdAtHumans,
    required this.countProducts,
    required this.total,
    required this.products,
  });

  CartDataModel copyWith({
    int? id,
    String? oid,
    int? status,
    DateTime? createdAt,
    String? createdAtHumans,
    int? countProducts,
    int? total,
    List<CartProductModel>? products,
  }) {
    return CartDataModel(
      id: id ?? this.id,
      oid: oid ?? this.oid,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      createdAtHumans: createdAtHumans ?? this.createdAtHumans,
      countProducts: countProducts ?? this.countProducts,
      total: total ?? this.total,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'oid': oid});
    result.addAll({'status': status});
    result.addAll({'createdAt': createdAt.millisecondsSinceEpoch});
    result.addAll({'createdAtHumans': createdAtHumans});
    result.addAll({'countProducts': countProducts});
    result.addAll({'total': total});
    result.addAll({'products': products.map((x) => x.toMap()).toList()});

    return result;
  }

  factory CartDataModel.fromMap(Map<dynamic, dynamic> map) {
    return CartDataModel(
      id: map['id']?.toInt() ?? 0,
      oid: map['oid'] ?? '',
      status: map['status']?.toInt() ?? 0,
      createdAt: DateTime.parse(map['created_at']),
      createdAtHumans: map['created_at_humans'] ?? '',
      countProducts: map['countProducts']?.toInt() ?? 0,
      total: map['total']?.toInt() ?? 0,
      products: List<CartProductModel>.from(map['products']?.map((x) => CartProductModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CartDataModel.fromJson(String source) => CartDataModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CartDataModel(id: $id, oid: $oid, status: $status, createdAt: $createdAt, createdAtHumans: $createdAtHumans, countProducts: $countProducts, total: $total, products: $products)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartDataModel &&
        other.id == id &&
        other.oid == oid &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.createdAtHumans == createdAtHumans &&
        other.countProducts == countProducts &&
        other.total == total &&
        listEquals(other.products, products);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        oid.hashCode ^
        status.hashCode ^
        createdAt.hashCode ^
        createdAtHumans.hashCode ^
        countProducts.hashCode ^
        total.hashCode ^
        products.hashCode;
  }
}
