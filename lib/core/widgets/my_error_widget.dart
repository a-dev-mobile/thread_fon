import 'package:flutter/material.dart';
import 'package:threadfon/core/widgets/choice_card.dart';
import 'package:threadfon/localization/l10n.dart';
// Package imports:

class MyErrorWidget extends StatelessWidget {
  final String? errorMsg;
  final VoidCallback onRetry;

  const MyErrorWidget({
    super.key,
    required this.errorMsg,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;

    return Center(
      child: ChoiceCard(
        isHeader: false,
        onTap: null, // Не кликабельно
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                errorMsg ?? localization.generalError,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(localization.retry),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
