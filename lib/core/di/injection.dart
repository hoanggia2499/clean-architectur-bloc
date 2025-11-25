import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:base_project/core/network/dio_client.dart';
import 'package:base_project/core/network/token_storage.dart';
import 'package:base_project/core/network/auth_interceptor.dart';

// Features
import 'package:base_project/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:base_project/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:base_project/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:base_project/features/auth/domain/repositories/auth_repository.dart';
import 'package:base_project/features/auth/domain/usecases/login_usecase.dart';
import 'package:base_project/features/auth/presentation/bloc/auth_bloc.dart';


final sl = GetIt.instance;

void init() {
  // =======================================================================
  // Features - Auth
  // =======================================================================
  // Blocs
  sl.registerFactory(() => AuthBloc(loginUseCase: sl()));

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), tokenStorage: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  // =======================================================================
  // Core - Network
  // =======================================================================
  sl.registerLazySingleton(() => DioClient(sl(), sl()));
  sl.registerLazySingleton(() => AuthInterceptor(sl(), sl()));
  sl.registerLazySingleton(() => TokenStorage(sl()));
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => const FlutterSecureStorage());
}
