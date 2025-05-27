import 'package:dartz/dartz.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:my_task_products/core/apis/api/api_services.dart';
import 'package:my_task_products/core/apis/error/error_model.dart';
import 'package:my_task_products/core/apis/error/server_exception.dart';
import 'package:my_task_products/core/apis/links/api_keys.dart';
import 'package:my_task_products/core/apis/links/end_points.dart';
import 'package:my_task_products/core/classes/my_logger.dart';
import 'package:my_task_products/core/storage/pref_services.dart';
import 'package:my_task_products/core/storage/secure_storage_service.dart';
import 'package:my_task_products/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:my_task_products/features/auth/data/models/login_model.dart';
import 'package:my_task_products/features/auth/data/models/user_model.dart';

class AuthRemoteDataSourceImp extends AuthRemoteDataSource {
  final ApiServices apiServices;

  AuthRemoteDataSourceImp({required this.apiServices});

  @override
  Future logOut() async {
    // TODO: implement logOut
    try {
      await SecureStorageService.instance.deleteAllValue();
      await PrefServices.instance.clearAllData();
    } on ServerException catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<ErrorModel, LoginModel>> login({
    required String userName,
    required String password,
    // int expiresInMins = 30,
  }) async {
    // TODO: implement

    try {
      final response = await apiServices.post(
        EndPoints.login,
        data: {
          ApiKeys.username: userName,
          ApiKeys.password: password,
          //ApiKeys.expiresInMins: expiresInMins.toString(),
        },
      );
      final loginUser = LoginModel.fromJson(response);
      MyLogger.instance.printLog("token${loginUser.accessToken}");
      final jwtDecoder = JwtDecoder.decode(loginUser.accessToken!);
      SecureStorageService.instance.setValue(
        key: ApiKeys.accessToken,
        value: loginUser.accessToken!,
      );
      SecureStorageService.instance.setValue(
        key: ApiKeys.refreshToken,
        value: loginUser.refreshToken!,
      );
      PrefServices.instance.saveData(
        key: ApiKeys.id,
        value: jwtDecoder[ApiKeys.id],
      );
      MyLogger.instance.printLog("success login");
      return Right(loginUser);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<ErrorModel, UserModel>> register({
    required String firstName,
    required String lastName,
    required String age,
    required String userName,
    required String password,
  }) async {
    // TODO: implement register
    try {
      final response = await apiServices.post(
        EndPoints.addUser,
        data: {
          ApiKeys.firstName: firstName,
          ApiKeys.lastName: lastName,
          ApiKeys.age: age,
          ApiKeys.username: userName,
          ApiKeys.password: password,
        },
      );
      //* if used http
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   MyLogger.instance.printLog("status code ${response.statusCode}");
      //   final data = jsonDecode(response.body);
      //   MyLogger.instance.printLog("data");
      //   final user = UserModel.fromJson(data);
      //   return Right(user);
      // } else {
      //   final errorData = jsonDecode(response.body);
      //   return Left(
      //     ErrorModel(message: errorData[ApiKeys.message] ?? 'Unexpected error'),
      //   );
      // }
      final user = UserModel.fromJson(response);
      return Right(user);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
