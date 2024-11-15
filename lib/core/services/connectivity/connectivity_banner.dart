// lib/core/connectivity/connectivity_banner.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'connectivity_bloc.dart';
import 'connectivity_state.dart';

class ConnectivityBanner extends StatelessWidget {
  const ConnectivityBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        if (state is ConnectivityOffline) {
          return Positioned(
            bottom: 0,
            child: Container(
              color: Colors.red,
              padding: const EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width,
              child: const Text(
                'Нет подключения к интернету',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
