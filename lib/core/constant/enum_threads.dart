enum EnumThreads {
  metric,
  imperial,
}

extension $EnumThreads on EnumThreads {
  bool get isMetric => this == EnumThreads.metric;
  bool get isImperial => this == EnumThreads.imperial;
}
