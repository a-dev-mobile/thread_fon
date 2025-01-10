// lib/features/trapezoidal_threads/views/trapezoidal_thread_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/core/constant/enum_navigation_status.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/widgets/loading_widget.dart';
import 'package:threadfon/core/widgets/my_card.dart';
import 'package:threadfon/core/widgets/my_error_widget.dart';
import 'package:threadfon/features/05_trapezoidal_threads/diameter_selection/bloc/trapezoidal_thread_bloc.dart';
import 'package:threadfon/features/05_trapezoidal_threads/diameter_selection/models/trapezoidal_thread_model.dart';
import 'package:threadfon/features/05_trapezoidal_threads/diameter_selection/repositories/trapezoidal_thread_repository.dart';
import 'package:threadfon/features/05_trapezoidal_threads/tolerance_selection/views/trapezoidal_tolerance_selection_screen.dart';
import 'package:threadfon/localization/generated/l10n.dart';
import 'package:threadfon/localization/l10n_extension.dart';

class TrapezoidalThreadScreen extends StatefulWidget {
  static const String path = '/TrapezoidalThreadScreen';
  static const String name = 'TrapezoidalThreadScreen';

  const TrapezoidalThreadScreen({super.key});

  @override
  State<TrapezoidalThreadScreen> createState() => _TrapezoidalThreadScreenState();
}

class _TrapezoidalThreadScreenState extends State<TrapezoidalThreadScreen> {
  late TrapezoidalThreadBloc _bloc;
  late ScrollController _scrollController; // Added scroll controller

  @override
  void initState() {
    super.initState();
    final ApiService apiService = context.read<ApiService>();
    final LocalStorage localStorage = context.read<LocalStorage>();
    final LanguageBloc languageBloc = context.read<LanguageBloc>();
    final TrapezoidalThreadRepository repository = TrapezoidalThreadRepository(apiService: apiService);

    _bloc = TrapezoidalThreadBloc(
      repository: repository,
      localStorage: localStorage,
      languageBloc: languageBloc,
    )..loadThreads();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TrapezoidalThreadBloc>.value(
      value: _bloc,
      child: _TrapezoidalThreadView(_bloc),
    );
  }
}

class _TrapezoidalThreadView extends StatefulWidget {
  const _TrapezoidalThreadView(this.bloc);
  final TrapezoidalThreadBloc bloc;

  @override
  State<_TrapezoidalThreadView> createState() => _TrapezoidalThreadViewState();
}

class _TrapezoidalThreadViewState extends State<_TrapezoidalThreadView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GeneratedLocalization localization = context.l10n;
    final TrapezoidalThreadBloc bloc = widget.bloc;

    return BlocListener<TrapezoidalThreadBloc, TrapezoidalThreadState>(
      listenWhen: (TrapezoidalThreadState previous, TrapezoidalThreadState current) =>
          previous.enumNavigationStatus != current.enumNavigationStatus,
      listener: (BuildContext context, TrapezoidalThreadState state) async {
        if (state.enumNavigationStatus.isNavigation) {
          await context.pushNamed(TrapezoidalToleranceSelectionScreen.name);
          bloc.resetNavigationStatus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('localization.select_diameter_and_pitch'),
        ),
        body: BlocBuilder<TrapezoidalThreadBloc, TrapezoidalThreadState>(
          buildWhen: (TrapezoidalThreadState previous, TrapezoidalThreadState current) =>
              previous.enumPageStatus != current.enumPageStatus || previous.threads != current.threads,
          builder: (BuildContext context, TrapezoidalThreadState state) {
            switch (state.enumPageStatus) {
              case EnumStatus.loading:
                return const LoadingWidget();
              case EnumStatus.error:
                return MyErrorWidget(
                  errorMsg: state.errorMsg,
                  onRetry: () => bloc.loadThreads(),
                );
              case EnumStatus.success:
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_scrollController.hasClients) {
                    _scrollController.jumpTo(state.scrollPosition);
                  }
                });

                return ListView.separated(
                  controller: _scrollController,
                  itemCount: state.threads.length,
                  separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8.0),
                  itemBuilder: (BuildContext context, int index) {
                    final TrapezoidalThreadModel thread = state.threads[index];
                    return TrapezoidalThreadCard(
                      designation: thread.designation,
                      onTap: () => bloc.preparationNavigation(
                        thread,
                        _scrollController.position.pixels,
                      ),
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}

class TrapezoidalThreadCard extends StatelessWidget {
  final String designation;

  final VoidCallback onTap;

  const TrapezoidalThreadCard({
    required this.designation,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MyCard(
      onTap: onTap,
      child: Text(
        designation,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
