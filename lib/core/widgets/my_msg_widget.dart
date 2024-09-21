import 'package:flutter/material.dart';

class MyMsgWidget extends StatelessWidget {
  const MyMsgWidget({
    required this.msg,
    super.key,
  });
  final String msg;
  @override
  Widget build(BuildContext context) => Center(child: Text(msg));
}
