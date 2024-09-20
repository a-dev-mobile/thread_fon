import 'package:flutter/material.dart';

class MyMsgWidget extends StatelessWidget {
  const MyMsgWidget({
    Key? key,
    required this.msg,
  }) : super(key: key);
  final String msg;
  @override
  Widget build(BuildContext context) => Center(child: Text(msg));
}
