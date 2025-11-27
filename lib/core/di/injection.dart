import 'package:base_project/features/assessment/presentation/bloc/assessment_bloc.dart';
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

import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/calendar/presentation/bloc/calendar_bloc.dart';
import '../../features/dash_board/presentation/bloc/dash_board_bloc.dart';
import '../../features/list/presentation/bloc/_bloc.dart';

final sl = GetIt.instance;

void init() {
  // =======================================================================
  // Features - Auth
  // =======================================================================
  // Blocs
  sl.registerFactory(() => AuthBloc(loginUseCase: sl()));
  sl.registerFactory(() => DashBoardBloc());
  sl.registerFactory(() => ListBloc());
  sl.registerFactory(() => CalendarBloc());
  sl.registerFactory(() => AssessmentBloc());

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
