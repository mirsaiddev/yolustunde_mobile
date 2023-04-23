import 'dart:convert';

class CartProductModel {
  final int id;
  final int times;
  final int orderId;
  final int productId;
  final int carId;
  final int companyId;
  final double price;
  final int status;
  final DateTime? renewDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String title;
  final String description;
  final String createdAtHumans;
  final dynamic car;
  CartProductModel({
    required this.id,
    required this.times,
    required this.orderId,
    required this.productId,
    required this.carId,
    required this.companyId,
    required this.price,
    required this.status,
    this.renewDate,
    this.createdAt,
    this.updatedAt,
    required this.title,
    required this.description,
    required this.createdAtHumans,
    required this.car,
  });

  CartProductModel copyWith({
    int? id,
    int? times,
    int? orderId,
    int? productId,
    int? carId,
    int? companyId,
    double? price,
    int? status,
    DateTime? renewDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? title,
    String? description,
    String? createdAtHumans,
    dynamic? car,
  }) {
    return CartProductModel(
      id: id ?? this.id,
      times: times ?? this.times,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      carId: carId ?? this.carId,
      companyId: companyId ?? this.companyId,
      price: price ?? this.price,
      status: status ?? this.status,
      renewDate: renewDate ?? this.renewDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAtHumans: createdAtHumans ?? this.createdAtHumans,
      car: car ?? this.car,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'times': times});
    result.addAll({'order_id': orderId});
    result.addAll({'product_id': productId});
    result.addAll({'car_id': carId});
    result.addAll({'company_id': companyId});
    result.addAll({'price': price});
    result.addAll({'status': status});
    if (renewDate != null) {
      result.addAll({'renew_date': renewDate!.millisecondsSinceEpoch});
    }
    if (createdAt != null) {
      result.addAll({'created_at': createdAt!.millisecondsSinceEpoch});
    }
    if (updatedAt != null) {
      result.addAll({'updated_at': updatedAt!.millisecondsSinceEpoch});
    }
    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'created_at_humans': createdAtHumans});
    result.addAll({'car': car});

    return result;
  }

  factory CartProductModel.fromMap(Map<String, dynamic> map) {
    return CartProductModel(
      id: map['id']?.toInt() ?? 0,
      times: map['times']?.toInt() ?? 0,
      orderId: map['orderId']?.toInt() ?? 0,
      productId: map['productId']?.toInt() ?? 0,
      carId: map['carId']?.toInt() ?? 0,
      companyId: map['companyId']?.toInt() ?? 0,
      price: map['price']?.toDouble() ?? 0.0,
      status: map['status']?.toInt() ?? 0,
      renewDate: map['renewDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['renewDate']) : null,
      createdAt: map['createdAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createdAt']) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt']) : null,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      createdAtHumans: map['createdAtHumans'] ?? '',
      car: map['car'] ?? null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartProductModel.fromJson(String source) => CartProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CartProductModel(id: $id, times: $times, orderId: $orderId, productId: $productId, carId: $carId, companyId: $companyId, price: $price, status: $status, renewDate: $renewDate, createdAt: $createdAt, updatedAt: $updatedAt, title: $title, description: $description, createdAtHumans: $createdAtHumans, car: $car)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartProductModel &&
        other.id == id &&
        other.times == times &&
        other.orderId == orderId &&
        other.productId == productId &&
        other.carId == carId &&
        other.companyId == companyId &&
        other.price == price &&
        other.status == status &&
        other.renewDate == renewDate &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.title == title &&
        other.description == description &&
        other.createdAtHumans == createdAtHumans &&
        other.car == car;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        times.hashCode ^
        orderId.hashCode ^
        productId.hashCode ^
        carId.hashCode ^
        companyId.hashCode ^
        price.hashCode ^
        status.hashCode ^
        renewDate.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        title.hashCode ^
        description.hashCode ^
        createdAtHumans.hashCode ^
        car.hashCode;
  }
}
