import 'package:equatable/equatable.dart';

class AuthResponseEntity extends Equatable {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;
  final String accessToken;
  final String refreshToken;

  const AuthResponseEntity({
    required this.accessToken,
    required this.refreshToken,
    this.id = 0,
    this.email = '',
    this.firstName = '',
    this.lastName = '',
    this.username = '',
    this.gender = '',
    this.image = '',
  });

  @override
  List<Object?> get props => [id, username, email, firstName, lastName, gender, image, accessToken, refreshToken];
}
