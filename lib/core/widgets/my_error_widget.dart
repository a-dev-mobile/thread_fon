import 'package:flutter/material.dart';
import 'package:threadfon/localization/generated/l10n.dart';
import 'package:threadfon/localization/l10n.dart';
import 'package:threadfon/localization/localization.dart';
// Package imports:

class MyErrorWidget extends StatelessWidget {
  final String errorMsg;
  final VoidCallback onRetry;

  const MyErrorWidget({
    Key? key,
    required this.errorMsg,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
        final l = context.l10n;
    // Используем Future.microtask, чтобы показать диалог после построения виджета
    Future.microtask(() {
      showDialog(
        context: context,
        barrierDismissible: false, // Запретить закрытие диалога при нажатии вне его
        builder: (context) {
          return AlertDialog(
            title:  Text(l.error),
            content: Text(errorMsg),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Закрыть диалог
                  onRetry(); // Вызвать колбэк повторной попытки
                },
                child:  Text(l.repeat),
              ),
            ],
          );
        },
      );
    });

    // Возвращаем пустой виджет, так как диалог уже отображается
    return const SizedBox.shrink();
  }
}
