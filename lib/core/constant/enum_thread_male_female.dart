import 'package:freezed_annotation/freezed_annotation.dart';

enum EnumThreadMaleFemale {
  @JsonValue('male')
  male,
  @JsonValue('female')
  female,
}

extension $EnumThreadMaleFemale on EnumThreadMaleFemale {
  bool get isMale => this == EnumThreadMaleFemale.male;
  bool get isFemale => this == EnumThreadMaleFemale.female;
}
