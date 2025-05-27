import 'package:dartz/dartz.dart';
import 'package:my_task_products/core/apis/error/error_model.dart';
import 'package:my_task_products/features/auth/data/models/login_model.dart';
import 'package:my_task_products/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<Either<ErrorModel, LoginModel>> login({
    required String userName,
    required String password,
    //int expiresInMins = 60,
  });
  Future<Either<ErrorModel, UserModel>> register({
    required String firstName,
    required String lastName,
    required String age,
    required String userName,
    required String password,
  });
  Future logOut();
}
