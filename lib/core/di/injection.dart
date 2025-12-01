import 'package:base_project/features/product_detail/presentation/bloc/product_detail_bloc.dart';
import 'package:base_project/features/products/domain/usecases/search_products_usecase.dart';
import 'package:base_project/features/search/presentation/bloc/search_bloc.dart';
import 'package:base_project/features/todo/presentation/bloc/todo_bloc.dart';
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

import 'package:base_project/features/products/data/datasources/products_remote_data_source.dart';
import 'package:base_project/features/products/data/repositories/products_repository_impl.dart';
import 'package:base_project/features/products/domain/repositories/products_repository.dart';
import 'package:base_project/features/products/domain/usecases/get_products_usecase.dart';
import 'package:base_project/features/products/presentation/bloc/products_bloc.dart';

import 'package:base_project/features/product_detail/data/datasources/product_detail_remote_data_source.dart';
import 'package:base_project/features/product_detail/data/repositories/product_detail_repository_impl.dart';
import 'package:base_project/features/product_detail/domain/repositories/product_detail_repository.dart';
import 'package:base_project/features/product_detail/domain/usecases/get_product_detail_usecase.dart';

import '../../features/assessment/presentation/bloc/assessment_bloc.dart';
import '../../features/dash_board/presentation/bloc/dash_board_bloc.dart';

final sl = GetIt.instance;

void init() {
  // Blocs
  sl.registerFactory(() => AuthBloc(sl()));
  sl.registerFactory(() => DashBoardBloc());
  sl.registerFactory(() => TodoBloc());
  sl.registerFactory(() => ProductsBloc(sl())); // No longer needs SearchUseCase
  sl.registerFactory(() => AssessmentBloc());
  sl.registerFactory(() => ProductDetailBloc(sl()));
  sl.registerFactory(() => SearchBloc(sl())); // Register SearchBloc

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => GetProductsUseCase(sl()));
  sl.registerLazySingleton(() => SearchProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetProductDetailUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ProductDetailRepository>(
    () => ProductDetailRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ProductsRemoteDataSource>(
    () => ProductsRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ProductDetailRemoteDataSource>(
    () => ProductDetailRemoteDataSourceImpl(sl()),
  );

  // Core - Network
  sl.registerLazySingleton(() => DioClient(sl(), sl()));
  sl.registerLazySingleton(() => AuthInterceptor(sl(), sl()));
  sl.registerLazySingleton(() => TokenStorage(sl()));
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => const FlutterSecureStorage());
}
