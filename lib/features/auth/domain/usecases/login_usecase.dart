import 'package:dartz/dartz.dart';
import 'package:base_project/core/error.dart';
import 'package:base_project/core/usecase.dart';
import 'package:base_project/features/auth/domain/entities/auth_response_entity.dart';
import 'package:base_project/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase implements UseCase<AuthResponseEntity, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, AuthResponseEntity>> call(LoginParams params) async {
    return await repository.login(params.username, params.password, params.expiresInMins);
  }
}

class LoginParams {
  final String username;
  final String password;
  final int expiresInMins;

  LoginParams(
      {required this.username,
      required this.password,
      this.expiresInMins = 30});
}
