import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_task_products/app_injections.dart' as di;
import 'package:my_task_products/core/routes/routes_generator.dart';
import 'package:my_task_products/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:my_task_products/features/products/presentation/cubit/products/filter_products/filter_products_cubit.dart';
import 'package:my_task_products/features/products/presentation/cubit/products/options/options_cubit.dart';
import 'package:my_task_products/features/products/presentation/cubit/products/product_cubit.dart';
import 'package:my_task_products/features/splash/presentation/pages/splash_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>(create: (context) => di.sl<AuthCubit>()),
            BlocProvider.value(value: di.sl<SharedCubit>()),
            BlocProvider<FilterProductsCubit>(
              create: (context) => di.sl<FilterProductsCubit>(),
            ),
            BlocProvider<ProductCubit>(
              create: (context) => di.sl<ProductCubit>(),
            ),
          ],
          child: MaterialApp(
            theme: ThemeData(appBarTheme: AppBarTheme(centerTitle: true)),
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RoutesGenerator.onGenerateRoute,
            home: child,
          ),
        );
      },
      child: SplashScreen(),
    );
  }
}
