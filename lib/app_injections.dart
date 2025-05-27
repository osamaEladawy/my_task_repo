import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:my_task_products/core/apis/api/api_services.dart';
import 'package:my_task_products/core/apis/api/dio_services.dart';
import 'package:my_task_products/core/classes/my_logger.dart';
import 'package:my_task_products/features/auth/auth_injections.dart';
import 'package:my_task_products/features/products/product_injections.dart';
import 'package:http/http.dart' as http;
import 'package:my_task_products/features/home_tap/home_tap_injections.dart';
import 'package:my_task_products/features/roles/roles_injections.dart';

GetIt sl = GetIt.instance;

appInjections() async {
  productsInjections();
  authInjections();
  homeTapInjections();
  rolesInjections();

  //* apis && network
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton<ApiServices>(() => DioServices(dio: sl.call()));

  try {
    final box = await Hive.openBox("myBox");
    sl.registerLazySingleton(() => box);
  } catch (e) {
    MyLogger.instance.printLog("❌ Hive openBox error: $e");
  }
}
