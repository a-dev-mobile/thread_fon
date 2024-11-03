// future_builder_n.dart
import 'package:flutter/material.dart';

typedef FutureBuilderNWidgetBuilder<T> = Widget Function(
  BuildContext context,
  List<T?> data,
  Object? error,
);

class FutureBuilderN<T> extends StatefulWidget {
  const FutureBuilderN({
    required this.futures,
    required this.builder,
    this.loadInParallel = true,
    super.key,
    this.loadingWidget,
    this.errorWidget,
  });

  final List<Future<T>> futures;
  final FutureBuilderNWidgetBuilder<T> builder;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final bool loadInParallel;

  @override
  State<FutureBuilderN<T>> createState() => _FutureBuilderNState<T>();
}

class _FutureBuilderNState<T> extends State<FutureBuilderN<T>> {
  late Future<List<T?>> _combinedFuture;

  @override
  void initState() {
    super.initState();
    _combinedFuture =
        widget.loadInParallel ? _loadInParallel() : _loadSequentially();
  }

  Future<List<T?>> _loadInParallel() async => Future.wait(widget.futures);

  Future<List<T?>> _loadSequentially() async {
    var results = <T?>[];
    for (final future in widget.futures) {
      try {
        final result = await future;
        results.add(result);
      } on Exception catch (e) {
        // Прерываем загрузку при первой же ошибке
        return Future.error(e);
      }
    }
    return results;
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<List<T?>>(
        future: _combinedFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return widget.loadingWidget ??
                const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return widget.errorWidget ??
                Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return widget.builder(context, snapshot.data!, null);
          } else {
            return widget.errorWidget ??
                const Center(child: Text('Unknown error occurred'));
          }
        },
      );
}
