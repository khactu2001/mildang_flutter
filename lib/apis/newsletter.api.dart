import 'package:flutter_mildang/apis/api.dart';
import 'package:flutter_mildang/apis/base.api.dart';
import 'package:flutter_mildang/model/newsletter_bookmarks_model.dart';
import 'package:flutter_mildang/model/newsletter_detail_model.dart';
import 'package:flutter_mildang/model/newsletter_list_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const String path = 'newsletter';
const String pathBookmark = 'newsletter/bookmarks';
BaseAPI api = BaseAPI();

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

Future<DataPagingList?> getNewsletters({Map<String, dynamic>? params}) async {
  final Map<String, dynamic>? response =
      await api.baseRequestWithToken('GET', path, params: params);
  if (response == null) return null;
  NewsletterListResponse newsletterListResponse =
      NewsletterListResponse.fromJson(response);
  return newsletterListResponse.data;
}

Future<DataPagingBookmark?> getNewsletterBookmarks(
    {Map<String, dynamic>? params}) async {
  try {
    final Map<String, dynamic>? response =
        await api.baseRequestWithToken('GET', pathBookmark, params: params);
    if (response == null) return null;
    NewsletterBookmarksResponse newsletterListResponse =
        NewsletterBookmarksResponse.fromJson(response);
    return newsletterListResponse.data;
  } catch (e) {
    throw Exception('Error: $e');
  }
}

Future<void> addNewsBookmark(NewsItems newsItem) async {}
