import 'package:yolustunde_mobile/models/user/user_model.dart';

extension GenderExtension on Gender {
  String toName() {
    switch (this) {
      case Gender.male:
        return 'Erkek';
      case Gender.female:
        return 'Kadın';
      default:
        return 'Belirtilmemiş';
    }
  }
}

extension StringGenderExtension on String {
  Gender toGender() {
    switch (this) {
      case 'male':
        return Gender.male;
      case 'female':
        return Gender.female;
      default:
        return Gender.unknown;
    }
  }
}
