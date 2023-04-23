import 'dart:convert';

class ProductModel {
  final int id;
  final String title;
  final String description;
  final int one_time;
  final int minutes;
  final bool is_active;
  final int price;
  final int discount;
  final String created_at;
  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.one_time,
    required this.minutes,
    required this.is_active,
    required this.price,
    required this.discount,
    required this.created_at,
  });

  ProductModel copyWith({
    int? id,
    String? title,
    String? description,
    int? one_time,
    int? minutes,
    int? bool,
    int? price,
    int? discount,
    String? created_at,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      one_time: one_time ?? this.one_time,
      minutes: minutes ?? this.minutes,
      is_active: is_active,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      created_at: created_at ?? this.created_at,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'one_time': one_time});
    result.addAll({'minutes': minutes});
    result.addAll({'is_active': is_active});
    result.addAll({'price': price});
    result.addAll({'discount': discount});
    result.addAll({'created_at': created_at});

    return result;
  }

  factory ProductModel.fromMap(Map<dynamic, dynamic> map) {
    return ProductModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      one_time: map['one_time']?.toInt() ?? 0,
      minutes: map['minutes']?.toInt() ?? 0,
      is_active: map['is_active'] == 1 ? true : false,
      price: map['price']?.toInt() ?? 0,
      discount: map['discount']?.toInt() ?? 0,
      created_at: map['created_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(id: $id, title: $title, description: $description, one_time: $one_time, minutes: $minutes, is_active: $is_active, price: $price, discount: $discount, created_at: $created_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.one_time == one_time &&
        other.minutes == minutes &&
        other.is_active == is_active &&
        other.price == price &&
        other.discount == discount &&
        other.created_at == created_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        one_time.hashCode ^
        minutes.hashCode ^
        is_active.hashCode ^
        price.hashCode ^
        discount.hashCode ^
        created_at.hashCode;
  }
}
