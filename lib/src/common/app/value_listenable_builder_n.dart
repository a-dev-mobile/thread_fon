// value_listenable_builder_n.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef ValueListenableBuilderNWidgetBuilder<T> = Widget Function(
  BuildContext context,
  List<T> values,
  Widget? child,
);

class ValueListenableBuilderN<T> extends StatefulWidget {

  const ValueListenableBuilderN({
    required this.listenable,
    required this.builder,
    super.key,
    this.child,
  });
  final List<ValueListenable<T>> listenable;
  final ValueListenableBuilderNWidgetBuilder<T> builder;
  final Widget? child;

  @override
  _ValueListenableBuilderNState<T> createState() => _ValueListenableBuilderNState<T>();
}

class _ValueListenableBuilderNState<T> extends State<ValueListenableBuilderN<T>> {
  late List<T> _currentValues;

  @override
  void initState() {
    super.initState();
    _currentValues = widget.listenable.map((e) => e.value).toList();
    for (final listenable in widget.listenable) {
      listenable.addListener(_updateValues);
    }
  }

  @override
  void didUpdateWidget(covariant ValueListenableBuilderN<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.listenable != widget.listenable) {
      for (final listenable in oldWidget.listenable) {
        listenable.removeListener(_updateValues);
      }
      _currentValues = widget.listenable.map((e) => e.value).toList();
      for (final listenable in widget.listenable) {
        listenable.addListener(_updateValues);
      }
    }
  }

  @override
  void dispose() {
    for (final listenable in widget.listenable) {
      listenable.removeListener(_updateValues);
    }
    super.dispose();
  }

  void _updateValues() {
    setState(() {
      _currentValues = widget.listenable.map((e) => e.value).toList();
    });
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _currentValues, widget.child);
}
