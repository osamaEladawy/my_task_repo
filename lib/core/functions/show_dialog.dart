import 'package:flutter/material.dart';

Widget alert(String title, String content, List<Widget>? actions) {
  return AlertDialog(
    title: Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(),
    ),
    content: Text(
      content,
      textAlign: TextAlign.center,
      style: const TextStyle(),
    ),
    actions: actions,
  );
}
