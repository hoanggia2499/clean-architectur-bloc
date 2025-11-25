import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:base_project/core/error.dart';
import 'package:base_project/core/network/token_storage.dart';
import 'package:base_project/features/auth/domain/entities/auth_response_entity.dart';
import 'package:base_project/features/auth/domain/repositories/auth_repository.dart';
import 'package:base_project/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter/foundation.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final TokenStorage tokenStorage;

  AuthRepositoryImpl(
      {required this.remoteDataSource, required this.tokenStorage});

  @override
  Future<Either<Failure, AuthResponseEntity>> login(
      String username, String password, int expiresInMins) async {
    try {
      final authResponse = await remoteDataSource.login(username, password, expiresInMins);
      await tokenStorage.saveTokens(
        accessToken: authResponse.accessToken,
        refreshToken: authResponse.refreshToken,
      );
      return Right(authResponse);
    } on DioException catch (e) {
      // The error message here will be the one we created in the interceptor
      // for timeout errors, or the default Dio error message for others.
      return Left(ServerFailure(e.message ?? 'An unexpected error occurred'));
    } catch (e) {
      // For any other non-Dio exceptions
      return Left(ServerFailure('An unknown error occurred'));
    }
  }
}
