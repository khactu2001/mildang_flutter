import 'package:flutter_mildang/model/login_model.dart';
import 'package:flutter_mildang/utils/utilities.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

const String baseUrl = 'https://api-mildang.brickmate.kr/api/v1';
const String path = '/authentication/login';
// class DataClass<T> {
//   Map<String, dynamic> toJson() {
//     // return {
//     //   'refreshToken': refreshToken,
//     //   'accessToken': accessToken,
//     // };
//   }
// }

// String stringifyClass<T>(T model) {
//   return jsonEncode(model?.toJson?.());
// }

Future<LoginResponseModel> login(Map<String, dynamic> dataBody) async {
  var url = Uri.parse(baseUrl + path);
  // Await the http get response, then decode the json-formatted response.
  try {
    var response = await http.post(url, body: dataBody);
    if (response.statusCode == 200) {
      final decodedJson = jsonDecode(response.body);
      LoginResponseModel loginResponseModel =
          LoginResponseModel.fromJson(decodedJson);
      final data = loginResponseModel.data;
      final token = data.token;
      final user = data.user;

      // // // save the token to local storage
      await setLocalVariable(LocalKeyCustom.token, jsonEncode(token.toJson()));
      await setLocalVariable(LocalKeyCustom.user, jsonEncode(user.toJson()));

      return loginResponseModel;
    } else {
      throw Exception(response);
    }
  } catch (e) {
    throw Exception('Error login: $e');
  }
}

const String userPath = '/user/update-profile';

Future<String?> getHeader() async {
  final Map<String, dynamic>? token =
      await getLocalVariable(LocalKeyCustom.token);
  final Map<String, dynamic>? user =
      await getLocalVariable(LocalKeyCustom.user);
  if (user == null || token == null) {
    return null;
  }
  TokenModel tokenLocal = TokenModel.fromJson(token);
  return tokenLocal.accessToken;
}

Future<void> updateProfile(Map<String, dynamic> dataBody) async {
  var url = Uri.parse(baseUrl + userPath);
  try {
    // prepare header
    final String? header = await getHeader();
    print('header: $header');

    // call api
    var response = await http.put(url, body: dataBody, headers: {
      'Authorization': header != null ? 'Bearer $header' : '',
    });
    final decodedJson = jsonDecode(response.body);
    print(decodedJson['message']);
    // LoginResponseModel loginResponseModel =
    //     LoginResponseModel.fromJson(decodedJson);
    // print(loginResponseModel.message);
  } catch (e) {
    throw Exception('Error update profile: $e');
  }
}
