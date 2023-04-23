import 'dart:convert';

class CompanyTypeModel {
  final int id;
  final int orderNo;
  final String title;
  final String type;
  CompanyTypeModel({
    required this.id,
    required this.orderNo,
    required this.title,
    required this.type,
  });

  CompanyTypeModel copyWith({
    int? id,
    int? orderNo,
    String? title,
    String? type,
  }) {
    return CompanyTypeModel(
      id: id ?? this.id,
      orderNo: orderNo ?? this.orderNo,
      title: title ?? this.title,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'orderNo': orderNo});
    result.addAll({'title': title});
    result.addAll({'type': type});

    return result;
  }

  factory CompanyTypeModel.fromMap(Map<dynamic, dynamic> map) {
    return CompanyTypeModel(
      id: map['id']?.toInt() ?? 0,
      orderNo: map['order_no']?.toInt() ?? 0,
      title: map['title'] ?? '',
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyTypeModel.fromJson(String source) => CompanyTypeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CompanyTypeModel(id: $id, orderNo: $orderNo, title: $title, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CompanyTypeModel && other.id == id && other.orderNo == orderNo && other.title == title && other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^ orderNo.hashCode ^ title.hashCode ^ type.hashCode;
  }
}
