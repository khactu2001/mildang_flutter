import 'package:flutter/material.dart';
import 'package:flutter_mildang/apis/newsletter.api.dart';
import 'package:flutter_mildang/model/newsletter_bookmarks_model.dart';
import 'package:flutter_mildang/model/newsletter_list_model.dart';

class NewsletterBookmarkProvider extends ChangeNotifier {
  // List<NewsItems> _newsBookmarks = [];
  DataPagingBookmark _dataPagingBookmark = DataPagingBookmark();

  void updateBookmarks(List<NewsItems> bookmarks) {
    // _newsBookmarks = bookmarks;
    notifyListeners();
  }

  void removeNewsBookmark(int id) {
    // _newsBookmarks.removeWhere((item) => item.id == id);
    _dataPagingBookmark.items?.removeWhere((item) => item.id == id);
    notifyListeners();
    removeNewsBookmarkApi(id);
  }

  void addNewsBookmark(NewsItems newsItems) {
    // _newsBookmarks.add(newsItems);
    _dataPagingBookmark.items?.add(newsItems);
    notifyListeners();
    addNewsBookmarkApi(newsItems.id!);
  }

  void concatNewsBookmarks(List<NewsItems> newsBookmarks) {
    // _newsBookmarks.addAll(newsBookmarks);
    notifyListeners();
  }

  // List<NewsItems> get bookmarks {
  //   return _newsBookmarks;
  // }

  DataPagingBookmark get dataPagingBookmark {
    return _dataPagingBookmark;
  }

  Future<void> providerGetListBookmarks(Map<String, dynamic> params) async {
    final paging = _dataPagingBookmark.paging;
    print(paging?.toJson().toString());
    // if the first time -> get the list
    if (paging == null || paging.page == 1) {
      final response = await getNewsletterBookmarks(params: params);
      // final itemsFetched = response?.items ?? [];
      // _newsBookmarks = itemsFetched;
      _dataPagingBookmark = response!;
      notifyListeners();
      return;
    }
    // if the second time -> compare page with total page
    if (paging.page! > paging.totalPage!) {
      return;
    }

    // concat result with previous items
    final response = await getNewsletterBookmarks(params: params);
    final itemsFetched = response?.items ?? [];
    // _newsBookmarks.addAll(itemsFetched);
    _dataPagingBookmark.items!.addAll(itemsFetched);
    _dataPagingBookmark.paging = response!.paging;
    notifyListeners();
  }
}
