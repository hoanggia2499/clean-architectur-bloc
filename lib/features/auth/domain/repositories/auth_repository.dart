import 'package:dartz/dartz.dart';
import 'package:base_project/core/error.dart';
import 'package:base_project/features/auth/domain/entities/auth_response_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponseEntity>> login(String username, String password, int expiresInMins);
}
