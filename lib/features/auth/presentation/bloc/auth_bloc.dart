import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_project/core/error.dart';
import 'package:base_project/features/auth/domain/usecases/login_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:base_project/features/auth/domain/entities/auth_response_entity.dart';
part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc(this.loginUseCase) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await loginUseCase(
          LoginParams(username: event.username, password: event.password));
      result.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(AuthFailure(message: failure.message));
          } else {
            emit(const AuthFailure(message: 'An unexpected error occurred.'));
          }
        },
        (authResponse) => emit(AuthSuccess(authResponse: authResponse)),
      );
    });
  }
}
