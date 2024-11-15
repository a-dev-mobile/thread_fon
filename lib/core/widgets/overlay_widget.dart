import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:threadfon/core/services/connectivity/connectivity_banner.dart';

class OverlayScreen extends StatefulWidget {
  const OverlayScreen({
    required this.child,
    required this.goRouterState,
    super.key,
  });
  final Widget child;
  final GoRouterState goRouterState;

  @override
  State<OverlayScreen> createState() => _OverlayScreenState();
}

class _OverlayScreenState extends State<OverlayScreen> {
  @override
  void initState() {
    super.initState();

    // final _ = context.read<InternetCubit>().checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    // final location = widget.goRouterState.uri.toString();

    return Scaffold(
      body: Stack(
        children: [
          widget.child,
          const ConnectivityBanner(),
        ],
      ),
    );
  }
}
