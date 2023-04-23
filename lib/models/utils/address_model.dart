import 'dart:convert';

class AddressModel {
  final int id;
  final int cityId;
  final int stateId;
  final double latitude;
  final double longitude;
  final int userId;
  final String title;
  final String address;
  final String type;
  final int buildingNo;
  final int floor;
  final int apartNo;
  AddressModel({
    required this.id,
    required this.cityId,
    required this.stateId,
    required this.latitude,
    required this.longitude,
    required this.userId,
    required this.title,
    required this.address,
    required this.type,
    required this.buildingNo,
    required this.floor,
    required this.apartNo,
  });

  AddressModel copyWith({
    int? id,
    int? cityId,
    int? stateId,
    double? latitude,
    double? longitude,
    int? userId,
    String? title,
    String? address,
    String? type,
    int? buildingNo,
    int? floor,
    int? apartNo,
  }) {
    return AddressModel(
      id: id ?? this.id,
      cityId: cityId ?? this.cityId,
      stateId: stateId ?? this.stateId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      address: address ?? this.address,
      type: type ?? this.type,
      buildingNo: buildingNo ?? this.buildingNo,
      floor: floor ?? this.floor,
      apartNo: apartNo ?? this.apartNo,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'cityId': cityId});
    result.addAll({'stateId': stateId});
    result.addAll({'latitude': latitude});
    result.addAll({'longitude': longitude});
    result.addAll({'userId': userId});
    result.addAll({'title': title});
    result.addAll({'address': address});
    result.addAll({'type': type});
    result.addAll({'buildingNo': buildingNo});
    result.addAll({'floor': floor});
    result.addAll({'apartNo': apartNo});

    return result;
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id']?.toInt() ?? 0,
      cityId: map['city_id']?.toInt() ?? 0,
      stateId: map['state_id']?.toInt() ?? 0,
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      userId: map['user_id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      buildingNo: map['building_no']?.toInt() ?? 0,
      floor: map['floor']?.toInt() ?? 0,
      apartNo: map['apart_no']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) => AddressModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddressModel(id: $id, cityId: $cityId, stateId: $stateId, latitude: $latitude, longitude: $longitude, userId: $userId, title: $title, address: $address, type: $type, buildingNo: $buildingNo, floor: $floor, apartNo: $apartNo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddressModel &&
        other.id == id &&
        other.cityId == cityId &&
        other.stateId == stateId &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.userId == userId &&
        other.title == title &&
        other.address == address &&
        other.type == type &&
        other.buildingNo == buildingNo &&
        other.floor == floor &&
        other.apartNo == apartNo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        cityId.hashCode ^
        stateId.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        userId.hashCode ^
        title.hashCode ^
        address.hashCode ^
        type.hashCode ^
        buildingNo.hashCode ^
        floor.hashCode ^
        apartNo.hashCode;
  }
}
