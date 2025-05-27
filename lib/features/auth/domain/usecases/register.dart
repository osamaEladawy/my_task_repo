import 'package:dartz/dartz.dart';
import 'package:my_task_products/core/apis/error/error_model.dart';
import 'package:my_task_products/features/auth/domain/entities/user_entity.dart';
import 'package:my_task_products/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository authRepository;

  RegisterUseCase({required this.authRepository});

  Future<Either<ErrorModel, UserEntity>> call({
    required String firstName,
    required String lastName,
    required String age,
    required String userName,
    required String password,
  }) async =>await authRepository.register(
    firstName: firstName,
    lastName: lastName,
    age: age,
    userName:userName,
    password:password
  );
}
