import 'package:flutter/material.dart';
import 'package:threadfon/localization/generated/l10n.dart';
import 'package:threadfon/localization/l10n.dart';
import 'package:threadfon/localization/localization.dart';
// Package imports:

class MyErrorWidget extends StatefulWidget {
  final String? errorMsg;
  final VoidCallback onRetry;

  const MyErrorWidget({
    Key? key,
    required this.errorMsg,
    required this.onRetry,
  }) : super(key: key);

  @override
  _MyErrorWidgetState createState() => _MyErrorWidgetState();
}

class _MyErrorWidgetState extends State<MyErrorWidget> {
  bool _isDialogShown = false;

  @override
  void initState() {
    super.initState();
    // Используем WidgetsBinding, чтобы убедиться, что контекст доступен
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showErrorDialog();
    });
  }

  void _showErrorDialog() {
    if (_isDialogShown) return;

    setState(() {
      _isDialogShown = true;
    });

    final localization = context.l10n;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(localization.error),
          content: Text(widget.errorMsg ?? localization.generalError),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                widget.onRetry();
              },
              child: Text(localization.repeat),
            ),
          ],
        );
      },
    ).then((_) {
      setState(() {
        _isDialogShown = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Возвращаем основной контент виджета, например, сообщение об ошибке
    return Scaffold();
  }
}
