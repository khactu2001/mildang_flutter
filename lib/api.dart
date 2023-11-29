import 'package:flutter_mildang/model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

const String baseUrl = 'https://api-mildang.brickmate.kr/api/v1';
const String path = '/authentication/login';

Future<LoginResponseModel> login(Map<String, dynamic> dataBody) async {
  var url = Uri.parse(baseUrl + path);
  final prefs = await SharedPreferences.getInstance();

  // Await the http get response, then decode the json-formatted response.
  try {
    var response = await http.post(url, body: dataBody);
    // print('Number of books about http: ${jsonEncode(response)}');
    if (response.statusCode == 200) {
      // LoginResponseModel jsonResponse =
      //     jsonDecode(response.body) as LoginResponseModel;
      print('Number of books about http: ${response.body}');
      final decodedJson = jsonDecode(response.body);
      LoginResponseModel loginResponseModel =
          LoginResponseModel.fromJson(decodedJson);
      // UserModel user = jsonDecode(decodedJson.data);
      // print('Number of books about http: ${user.id}');
      final data = loginResponseModel.data;
      final token = data.token;
      final user = data.user;

      // // // save the token to local storage
      await prefs.setString('token', jsonEncode(token.toJson()));
      bool isSaveUser =
          await prefs.setString('user', jsonEncode(user.toJson()));
      print('isSaveUser: ${isSaveUser}');

      return loginResponseModel;
    } else {
      // print('Request failed with status: ${response.statusCode}.');
      throw Exception(response);
    }
  } catch (e) {
    throw Exception('Error login: $e');
  }
}
