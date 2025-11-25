import 'dart:convert';
import 'package:base_project/core/network/path.dart';
import 'package:flutter/services.dart';
import 'package:base_project/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:base_project/features/auth/data/models/auth_response_model.dart';

import '../../../../core/network/dio_client.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _dioClient;

  // In a real app, DioClient would be injected.
  // For this example, we simulate by reading a local JSON file.
  AuthRemoteDataSourceImpl(this._dioClient);
  @override
  Future<AuthResponseModel> login(
      String username, String password, int expiresInMins) async {
    try {
      final response = await _dioClient.request(
        PathURL.auth,
        method: MethodType.POST,
        data: <String, dynamic>{
          'username': username,
          'password': password,
          'expiresInMins': expiresInMins,
        },
      );
      return AuthResponseModel.fromJson(response.data!);
    } catch (e) {
      throw Exception('Invalid credentials $e');
    }
  }
}
