import 'package:my_task_products/app_injections.dart';
import 'package:my_task_products/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:my_task_products/features/auth/data/datasources/remote/auth_remote_data_source_imp.dart';
import 'package:my_task_products/features/auth/data/repositories/auth_repository_imp.dart';
import 'package:my_task_products/features/auth/domain/repositories/auth_repository.dart';
import 'package:my_task_products/features/auth/domain/usecases/login.dart';
import 'package:my_task_products/features/auth/domain/usecases/logout.dart';
import 'package:my_task_products/features/auth/domain/usecases/register.dart';
import 'package:my_task_products/features/auth/presentation/cubit/auth_cubit.dart';

void authInjections() {
  //* cubits
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      loginUseCase: sl.call(),
      registerUseCase: sl.call(),
      logoutUseCase: sl.call(),
    ),
  );

  //* repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImp(authRemoteDataSource: sl.call()),
  );

  //* data
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImp(apiServices: sl.call()),
  );

  //* use cases
  sl.registerLazySingleton(() => LoginUseCase(authRepository: sl.call()));
  sl.registerLazySingleton(() => RegisterUseCase(authRepository: sl.call()));
  sl.registerLazySingleton(() => LogoutUseCase(authRepository: sl.call()));
}
