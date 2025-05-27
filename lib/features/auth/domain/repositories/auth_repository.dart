import 'package:dartz/dartz.dart';
import 'package:my_task_products/core/apis/error/error_model.dart';
import 'package:my_task_products/features/auth/domain/entities/login_entity.dart';
import 'package:my_task_products/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<ErrorModel, LoginEntity>> login({
    required String userName,
    required String password,
   // int expiresInMins = 60,
  });
  Future<Either<ErrorModel, UserEntity>> register({
    required String firstName,
    required String lastName,
    required String age,
    required String userName,
    required String password,
  });
  Future logOut();
}
