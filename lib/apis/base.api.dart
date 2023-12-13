import 'package:flutter_mildang/apis/api.dart';
import 'package:flutter_mildang/model/newsletter_detail_model.dart';
import 'package:flutter_mildang/provider/authen_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const String path = 'newsletter';

Future<Data?> getNewsletterDetail(int id) async {
  var url = Uri.parse('$baseUrl/$path/$id');
  // final AuthenModel authen = AuthenModel().getAuthenticated;
  final String? token = await getHeader();
  if (token == null) return null;
  try {
    var response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      NewsDetailModel newsModel = NewsDetailModel.fromJson(jsonResponse);
      return newsModel.data;
    }
    return null;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<Data?> getNewsletters() async {
  var url = Uri.parse('$baseUrl/$path');
  final String? token = await getHeader();
  if (token == null) return null;
  try {
    var response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      print(jsonResponse);
      NewsDetailModel newsModel = NewsDetailModel.fromJson(jsonResponse);
      print(newsModel);
      return newsModel.data;
    }
    return null;
  } catch (e) {
    print(e);
    return null;
  }
}

class BaseAPI {
  final AuthenModel authenModel;
  // String _baseUrl = 'https://api-mildang.brickmate.kr/api/v1';

  BaseAPI(this.authenModel);

  Future<void> get(
    String path,
  ) async {}
}
