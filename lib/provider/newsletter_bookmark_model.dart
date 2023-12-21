import 'package:flutter/material.dart';
import 'package:flutter_mildang/apis/newsletter.api.dart';
import 'package:flutter_mildang/model/newsletter_list_model.dart';

class NewsletterBookmarkProvider extends ChangeNotifier {
  List<NewsItems> _newsBookmarks = [];

  void updateBookmarks(List<NewsItems> bookmarks) {
    _newsBookmarks = bookmarks;
    notifyListeners();
  }

  void removeNewsBookmark(NewsItems newsItems) {
    _newsBookmarks.remove(newsItems);
    notifyListeners();
  }

  void addNewsBookmark(NewsItems newsItems) {
    _newsBookmarks.add(newsItems);
    notifyListeners();
  }

  void concatNewsBookmarks(List<NewsItems> newsBookmarks) {
    _newsBookmarks.addAll(newsBookmarks);
    notifyListeners();
  }

  List<NewsItems> get bookmarks {
    return _newsBookmarks;
  }

  Future<void> providerGetListBookmarks(Map<String, dynamic> params) async {
    // try {
    final response = await getNewsletterBookmarks(params: params);
    // if (response == null) {
    //   throw Exception('Failed to fetch data');
    // }
    _newsBookmarks.addAll(response?.items ?? []);
    notifyListeners();
    // } catch (e) {
    //   throw Exception('Error: $e');
    // }
  }
}
