// import 'dart:io';

import 'dart:convert';

import 'package:flutter_mildang/apis/api.dart';
import 'package:flutter_mildang/model/newsletter_detail_model.dart';
import 'package:flutter_mildang/model/newsletter_list_model.dart';
// import 'package:flutter_mildang/provider/authen_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

// import 'package:http/http.dart';

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

// Future<Data?> getNewsletters() async {
//   var url = Uri.parse('$baseUrl/$path');
//   final String? token = await getHeader();
//   if (token == null) return null;
//   try {
//     var response = await http.get(url, headers: {
//       'Authorization': 'Bearer $token',
//     });
//     if (response.statusCode == 200) {
//       var jsonResponse =
//           convert.jsonDecode(response.body) as Map<String, dynamic>;
//       print(jsonResponse);
//       NewsDetailModel newsModel = NewsDetailModel.fromJson(jsonResponse);
//       print(newsModel);
//       return newsModel.data;
//     }
//     return null;
//   } catch (e) {
//     print(e);
//     return null;
//   }
// }

// convert all values non-string to string
String encodeParams(Map<String, dynamic> queryParams) {
  String queryString = '';
  queryParams.forEach((key, value) {
    if (queryString.isNotEmpty) {
      queryString += '&';
    }
    queryString +=
        Uri.encodeComponent(key) + '=' + Uri.encodeComponent(value.toString());
  });

  return queryString;
}

class BaseAPI {
  static String baseUrl = 'https://api-mildang.brickmate.kr/api/v1';

  Future<Map<String, dynamic>?> baseRequestWithToken(
    String method,
    String url, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
  }) async {
    print(params);
    final String paramsString = params != null ? encodeParams(params) : '';

    final urlEndpoint = Uri.parse("$baseUrl/$url?$paramsString");

    http.Request request = http.Request(method, urlEndpoint);
    if (body != null) {
      request.body = jsonEncode(body);
    }
    try {
      request.headers['accept'] = '*/*';
      final token = await getHeader();
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      final response = await HttpClient().send(request);
      final bodyResponse = await response.stream.bytesToString();
      final decodedJSON = jsonDecode(bodyResponse) as Map<String, dynamic>;

      return decodedJSON;
    } catch (e) {
      print('Error $e');
      return null;
    }
  }

  // Future
}

class HttpClient extends http.BaseClient {
  final http.Client _client = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request);
  }
}
