import 'package:my_task_products/app_injections.dart';
import 'package:my_task_products/features/home_tap/presentation/cubit/home_tap_cubit.dart';

void homeTapInjections(){
  sl.registerFactory<HomeTapCubit>(()=>HomeTapCubit());
}