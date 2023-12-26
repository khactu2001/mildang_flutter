import 'package:flutter/material.dart';
import 'package:flutter_mildang/model/newsletter_list_model.dart';

abstract class Identifier {
  int get id;
}

class NewsletterBookmarkProviderTest<T extends Identifier>
    extends ChangeNotifier {
  final List<T> _list = [];

  void updateBookmarks(List<NewsItems> bookmarks) {
    notifyListeners();
  }

  void removeNewsBookmark(int id) {
    notifyListeners();
    _list.removeWhere((item) => item.id == id);
  }

  void addNewsBookmark(T newsItems) {
    notifyListeners();
    _list.add(newsItems);
  }

  void concatNewsBookmarks(List<T> newsBookmarks) {
    _list.addAll(newsBookmarks);
    notifyListeners();
  }
}
