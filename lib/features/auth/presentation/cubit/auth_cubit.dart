import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_task_products/core/classes/my_logger.dart';
import 'package:my_task_products/features/auth/domain/entities/login_entity.dart';
import 'package:my_task_products/features/auth/domain/entities/user_entity.dart';
import 'package:my_task_products/features/auth/domain/usecases/login.dart';
import 'package:my_task_products/features/auth/domain/usecases/logout.dart';
import 'package:my_task_products/features/auth/domain/usecases/register.dart';
import 'package:my_task_products/shared/widgets/snackbar.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial());
  //* use cases
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;

  //* formKey
  final signUpKey = GlobalKey<FormState>();
  final loginKey = GlobalKey<FormState>();

  //* sign up
  final TextEditingController usernameRegister = TextEditingController();
  final TextEditingController passwordRegister = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController secondName = TextEditingController();
  final TextEditingController age = TextEditingController();
  //* login
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool isShowPasswordLogin = false;
  bool isShowPasswordRegister = false;

  void displayPasswordLogin() {
    isShowPasswordLogin = !isShowPasswordLogin;
    emit(DisplayPasswordLogin(value: isShowPasswordLogin));
  }

  void displayPasswordRegister() {
    isShowPasswordRegister = !isShowPasswordRegister;
    emit(DisplayNewPassword(value: isShowPasswordRegister));
  }

  Future<void> login() async {
    if (loginKey.currentState!.validate()) {
      emit(LoginLoading());
      final response = await loginUseCase.call(
        userName: userName.text.trim(),
        password: password.text.trim(),
      );
      response.fold((error) => emit(LoginError(message: error.message!)), (
        loginEntity,
      ) {
        emit(LoginSuccess(loginEntity: loginEntity));
        userName.dispose();
        password.dispose();
      });
    } else {}
  }

  Future<void> register() async {
    if (signUpKey.currentState!.validate()) {
      emit(SignUpLoading());
      final response = await registerUseCase.call(
        firstName: firstName.text.trim(),
        lastName: secondName.text.trim(),
        age: age.text.trim(),
        userName: usernameRegister.text.trim(),
        password: passwordRegister.text.trim(),
      );
      response.fold((error) => emit(SignUpError(message: error.message!)), (
        user,
      ) {
        emit(SignUpSuccess(userEntity: user));
        firstName.clear();
        secondName.clear();
        age.clear();
        usernameRegister.clear();
        passwordRegister.clear();
      });
    } else {}
  }

  Future<void> logOut() async {
    emit(LogOutLoading());
    final response = await logoutUseCase.call();
    MyLogger.instance.printLog("$response");
    emit(LogOutSuccess());
  }
}
