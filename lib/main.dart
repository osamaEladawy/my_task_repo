import 'package:error_stack/error_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_task_products/app/my_app.dart';
import 'package:my_task_products/app_injections.dart' as di;
import 'package:my_task_products/core/classes/my_logger.dart';
import 'package:my_task_products/core/storage/pref_services.dart';
import 'package:my_task_products/core/storage/secure_storage_service.dart';
import 'package:my_task_products/shared/cubits/bloc_observer.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ErrorStack.init(); //* find bugs in development mode
  await SecureStorageService.instance.init(); //* important data (token)
  await PrefServices.instance.init(); //* any simple data not important
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.initFlutter(); //* save heavy data
  Hive.init(appDocumentDir.path);
  await di.appInjections(); //* initialize dependencies in my app
  Bloc.observer = MyBlocObserver(); //* observer changes in  my cubits
  MyLogger.instance.initLogger(); //* to display or hide data in console
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}
