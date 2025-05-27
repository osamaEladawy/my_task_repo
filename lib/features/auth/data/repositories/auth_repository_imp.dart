import 'package:dartz/dartz.dart';
import 'package:my_task_products/core/apis/error/error_model.dart';
import 'package:my_task_products/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:my_task_products/features/auth/domain/entities/login_entity.dart';
import 'package:my_task_products/features/auth/domain/entities/user_entity.dart';
import 'package:my_task_products/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImp extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImp({required this.authRemoteDataSource});

  @override
  Future logOut() async => await authRemoteDataSource.logOut();

  @override
  Future<Either<ErrorModel, LoginEntity>> login({
    required String userName,
    required String password,
   // int expiresInMins = 60,
  }) async => await authRemoteDataSource.login(
    userName: userName,
    password: password,
    //expiresInMins: expiresInMins,
  );

  @override
  Future<Either<ErrorModel, UserEntity>> register({
    required String firstName,
    required String lastName,
    required String age,
    required String userName,
    required String password,
  }) async => await authRemoteDataSource.register(
    firstName: firstName,
    lastName: lastName,
    age: age,
    userName: userName,
    password: password,
  );
}
