// import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  UserModel({
    required this.id,
    this.nickname,
    required this.phone,
    this.name,
    required this.email,
    required this.snsId,
    required this.accType,
    required this.role,
    required this.gender,
    this.birthday,
  });

  final int id;
  String? nickname;
  String phone;
  String? name;
  String email;
  final String? snsId;
  String? birthday;
  final String accType;
  final String role;
  final int gender;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TokenModel {
  const TokenModel({
    required this.refreshToken,
    required this.accessToken,
  });

  final String refreshToken;
  final String accessToken;

  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      _$TokenModelFromJson(json);
  Map<String, dynamic> toJson() => _$TokenModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LoginResponseDataModel {
  const LoginResponseDataModel({
    required this.token,
    required this.user,
  });

  final TokenModel token;
  final UserModel user;
  factory LoginResponseDataModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseDataModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LoginResponseModel {
  const LoginResponseModel({
    required this.data,
    required this.message,
    required this.status,
  });

  final LoginResponseDataModel data;
  final String message;
  final bool status;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
