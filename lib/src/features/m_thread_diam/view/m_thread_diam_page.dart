import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Импорт PostgreSQL пакета
import 'package:threadfon/src/common/styles/app_text_style.dart';
import 'package:threadfon/src/common/widgets/my_error_widget.dart';
import 'package:threadfon/src/common/widgets/my_load_widget.dart';
import 'package:threadfon/src/common/widgets/my_msg_widget.dart';
import 'package:threadfon/src/features/threads/view/m_thread/cubit/m_thread_cubit.dart';
import 'package:threadfon/src/features/m_thread_diam/view/database_service.dart';
import 'package:threadfon/src/features/m_thread_pitch/view/m_thread_pitch_page.dart';
import 'package:threadfon/src/common/localization/localization.dart';

class MThreadDiamPage extends StatelessWidget {
  const MThreadDiamPage({super.key});

  Future<List<String>> fetchDiameters() async {
    // Подключение к базе данных

    final db = DatabaseService.getInstance();
    final conn = await db.openConnection();

    // Выполнение SQL запроса
    var results = await db.query(
      conn,
      'SELECT DISTINCT diam FROM metric.main ORDER BY diam ASC',
    );

    // Преобразование данных в список строк
    var diameters = results.map((row) {
      var value = row[0] as double;
      return value.toString().replaceAll(RegExp(r'([.]*0)(?!.*\d)'), '');
    }).toList();

    await db.closeConnection(conn);

    return diameters;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(Localization.of(context).thread_diam),
        ),
        body: FutureBuilder<List<String>>(
          future: fetchDiameters(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const MyLoadWidget();
              default:
                return snapshot.hasError
                    ? MyErrorWidget(errorMsg: snapshot.error.toString())
                    : snapshot.data == null
                        ? const MyMsgWidget(msg: 'no data')
                        : ThreadDiamCard(
                            listString: snapshot.data!,
                          );
            }
          },
        ),
      );
}

class ThreadDiamCard extends StatelessWidget {
  const ThreadDiamCard({required this.listString, super.key});

  final List<String> listString;

  @override
  Widget build(BuildContext context) {
    final abrv = Localization.of(context).m_thread_abrv;
    return GridView.count(
      padding: const EdgeInsets.only(bottom: 120),
      crossAxisCount: 4,
      children: [
        for (final item in listString)
          InkWell(
            onTap: () {
              context.read<MThreadCubit>().setDiam(item);
              Navigator.push(
                context,
                MaterialPageRoute<MThreadPitchPage>(
                  builder: (_) => const MThreadPitchPage(),
                ),
              );
            },
            child: Center(
              child: Text(
                '$abrv $item',
                style: AppTextStyle.H2(),
              ),
            ),
          ),
      ],
    );
  }
}
