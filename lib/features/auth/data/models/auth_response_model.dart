import 'package:base_project/features/auth/domain/entities/auth_response_entity.dart';

class AuthResponseModel extends AuthResponseEntity {
  const AuthResponseModel({
    required super.id,
    required super.firstName,
    required super.email,
    required super.lastName,
    required super.gender,
    required super.image,
    required super.username,
    required super.accessToken,
    required super.refreshToken,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      // The 'data' wrapper is now handled by DioClient, so we parse from the root.
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      email: json['email'] as String,
      gender: json['gender'] as String,
      lastName: json['lastName'] as String,
      image: json['image'] as String,
      username: json['username'] as String,
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }
}
