import 'package:equatable/equatable.dart';
import 'package:base_project/features/auth/domain/entities/auth_response_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final AuthResponseEntity authResponse;

  const AuthSuccess({required this.authResponse});

  @override
  List<Object> get props => [authResponse];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});

  @override
  List<Object> get props => [message];
}
