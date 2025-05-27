import 'package:my_task_products/app_injections.dart';
import 'package:my_task_products/features/roles/presentation/cubit/roles_cubit.dart';

void rolesInjections(){
  sl.registerFactory<RolesCubit>(()=>RolesCubit());
}