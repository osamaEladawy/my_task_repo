import 'package:dartz/dartz.dart';
import 'package:my_task_products/core/apis/error/error_model.dart';
import 'package:my_task_products/features/auth/domain/entities/login_entity.dart';
import 'package:my_task_products/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  Future<Either<ErrorModel, LoginEntity>> call({
    required String userName,
    required String password,
   // int expiresInMins = 60,
  }) async => await authRepository.login(
    userName: userName,
    password: password,
   // expiresInMins: expiresInMins,
  );
}
