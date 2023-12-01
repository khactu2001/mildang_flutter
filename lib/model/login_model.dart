import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class UserModel {
  const UserModel({
    required this.id,
    this.username,
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
  final String? username;
  final String phone;
  final String? name;
  final String email;
  final String? snsId;
  final String? birthday;
  final String accType;
  final String role;
  final int gender;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'username': String? username,
        'phone': String phone,
        'name': String? name,
        'email': String email,
        'snsId': String snsId,
        'accType': String accType,
        'role': String role,
        'gender': int gender,
        'birthday': String? birthday,
      } =>
        UserModel(
          id: id,
          username: username,
          phone: phone,
          name: name,
          email: email,
          snsId: snsId,
          accType: accType,
          role: role,
          gender: gender,
          birthday: birthday,
        ),
      _ => throw const FormatException('Failed to load user.'),
    };
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'phone': phone,
      'name': name,
      'email': email,
      'snsId': snsId,
      'accType': accType,
      'role': role,
      'gender': gender,
      'birthday': birthday,
    };
  }

  // String get formatDatetime {
  //   if (birthday == null) {
  //     return DateTime.now().toString();
  //   }
  //   return formatter.format(birthday!);
  // }
}

class TokenModel {
  const TokenModel({
    required this.refreshToken,
    required this.accessToken,
  });

  final String refreshToken;
  final String accessToken;
  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      refreshToken: json['refreshToken'],
      accessToken: json['accessToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'refreshToken': refreshToken,
      'accessToken': accessToken,
    };
  }
}

class LoginResponseDataModel {
  const LoginResponseDataModel({
    required this.token,
    required this.user,
  });

  final TokenModel token;
  final UserModel user;
  factory LoginResponseDataModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseDataModel(
      token: TokenModel.fromJson(json['token']),
      user: UserModel.fromJson(json['user']),
    );
  }
}

class LoginResponseModel {
  const LoginResponseModel({
    required this.data,
    required this.message,
    required this.status,
  });

  final LoginResponseDataModel data;
  final String message;
  final bool status;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      status: json["status"],
      message: json['message'],
      data: LoginResponseDataModel.fromJson(json['data']),
    );
  }
}
