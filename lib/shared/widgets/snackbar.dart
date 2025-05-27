import 'package:flutter/material.dart';
import 'package:my_task_products/app/my_app.dart';
import 'package:my_task_products/shared/resources/color_resources.dart';

showSnackBar(String content) {
  ScaffoldMessenger.of(navigatorKey.currentContext!)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: ColorResources.primaryColor,
        content: Text(
          content,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
      ),
    );
}
