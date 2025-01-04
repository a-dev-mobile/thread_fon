import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/widgets/restart_widget.dart';
import 'package:threadfon/localization/generated/l10n.dart';
import 'package:threadfon/localization/l10n_extension.dart';
// Package imports:

class MyErrorWidget extends StatelessWidget {
  final String? errorMsg;
  final VoidCallback onRetry;

  const MyErrorWidget({
    required this.errorMsg,
    required this.onRetry,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final GeneratedLocalization localization = context.l10n;
    final LocalStorage localStorage =
        context.read<LocalStorage>(); // Получаем LocalStorage

    return Center(
      child: Card.outlined(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.error_outline,
                color: Theme.of(context).colorScheme.error,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                localization.error,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                errorMsg ?? localization.generalError,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(localization.retry),
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: () async {
                  // Очищаем локальное хранилище и кеш
                  await localStorage.clearAll();
                  // Перезапускаем приложение
                  RestartWidget.restartApp(context);
                },
                icon: const Icon(Icons.restart_alt),
                label: Text(localization.restartApp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
