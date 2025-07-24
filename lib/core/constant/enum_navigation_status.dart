// enum_navigation.dart
enum EnumNavigationStatus { initial, preparation, navigation }

extension $EnumNavigation on EnumNavigationStatus {
  bool get isInitial => this == EnumNavigationStatus.initial;
  bool get isNavigation => this == EnumNavigationStatus.navigation;
  bool get isPreparation => this == EnumNavigationStatus.preparation;
}
