// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threadfon/modules/threads/view/m_thread/view/m_thread_male_female/view/m_thread_male_female_page.dart';

import '../../app/services/local_storage_service.dart';
import '../../core/constants/storage.dart';
import '../../data/m_thread/m_thread_repository.dart';
import 'view/m_thread/cubit/m_thread_cubit.dart';

class ThreadsWrapperPage extends StatelessWidget {
  const ThreadsWrapperPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return const MThreadMaleFemalePage();
  }
}
