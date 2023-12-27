// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int,
      nickname: json['nickname'] as String?,
      phone: json['phone'] as String,
      name: json['name'] as String?,
      email: json['email'] as String,
      snsId: json['snsId'] as String?,
      accType: json['accType'] as String,
      role: json['role'] as String,
      gender: json['gender'] as int,
      birthday: json['birthday'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'phone': instance.phone,
      'name': instance.name,
      'email': instance.email,
      'snsId': instance.snsId,
      'birthday': instance.birthday,
      'accType': instance.accType,
      'role': instance.role,
      'gender': instance.gender,
    };

TokenModel _$TokenModelFromJson(Map<String, dynamic> json) => TokenModel(
      refreshToken: json['refreshToken'] as String,
      accessToken: json['accessToken'] as String,
    );

Map<String, dynamic> _$TokenModelToJson(TokenModel instance) =>
    <String, dynamic>{
      'refreshToken': instance.refreshToken,
      'accessToken': instance.accessToken,
    };

LoginResponseDataModel _$LoginResponseDataModelFromJson(
        Map<String, dynamic> json) =>
    LoginResponseDataModel(
      token: TokenModel.fromJson(json['token'] as Map<String, dynamic>),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseDataModelToJson(
        LoginResponseDataModel instance) =>
    <String, dynamic>{
      'token': instance.token.toJson(),
      'user': instance.user.toJson(),
    };

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    LoginResponseModel(
      data:
          LoginResponseDataModel.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String,
      status: json['status'] as bool,
    );

Map<String, dynamic> _$LoginResponseModelToJson(LoginResponseModel instance) =>
    <String, dynamic>{
      'data': instance.data.toJson(),
      'message': instance.message,
      'status': instance.status,
    };
