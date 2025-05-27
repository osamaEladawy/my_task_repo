import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_task_products/core/apis/links/api_keys.dart';
import 'package:my_task_products/core/routes/routes.dart';
import 'package:my_task_products/core/storage/secure_storage_service.dart';
import 'package:my_task_products/shared/extentions/navigations.dart';
import 'package:my_task_products/shared/resources/images_resources.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() async {
    final token = await SecureStorageService.instance.getValue(
      key: ApiKeys.accessToken,
    );

    Future.delayed(Duration(milliseconds: 300), () {
      if (token != null) {
        context.pushNamedAndRemoveUntil(Routes.homeTap);
      } else {
        context.pushReplacementNamed(Routes.roleScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          ImagesResources.logo,
          height: 250.h,
          width: 250.w,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
