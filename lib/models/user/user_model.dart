import 'dart:convert';

import 'package:yolustunde_mobile/models/company_model.dart';
import 'package:yolustunde_mobile/utils/extensions/gender_enum.dart';

class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final CompanyModel? company;
  final Gender? gender;
  final String? about;
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    this.company,
    this.gender,
    this.about,
  });

  UserModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'firstName': firstName});
    result.addAll({'lastName': lastName});
    result.addAll({'email': email});
    result.addAll({'phone': phone});

    return result;
  }

  factory UserModel.fromMap(Map<dynamic, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt() ?? 0,
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      company: map['company'] != null ? CompanyModel.fromMap(map['company']) : null,
      gender: map['gender'] != null ? map['gender'].toString().toGender() : null,
      about: map['about'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel && other.id == id && other.firstName == firstName && other.lastName == lastName && other.email == email && other.phone == phone;
  }

  @override
  int get hashCode {
    return id.hashCode ^ firstName.hashCode ^ lastName.hashCode ^ email.hashCode ^ phone.hashCode;
  }
}

enum Gender {
  male,
  female,
  unknown,
}
