enum EnumThreads { metric, imperial, trapezoidal, pipe }

extension $EnumThreads on EnumThreads {
  bool get isMetric => this == EnumThreads.metric;
  bool get isImperial => this == EnumThreads.imperial;
  bool get isTrapezoidal => this == EnumThreads.trapezoidal;
  bool get isPipe => this == EnumThreads.pipe;
}
