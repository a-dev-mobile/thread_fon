enum EnumUnits {
  mm,

  inch,
}

extension $EnumStatus on EnumUnits {
  bool get isMm => this == EnumUnits.mm;
  bool get isInch => this == EnumUnits.inch;
}
