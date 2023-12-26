import 'package:flutter/material.dart';
import 'package:flutter_mildang/apis/newsletter.api.dart';
import 'package:flutter_mildang/model/newsletter_bookmark_item_model.dart';

class NewsletterBookmarkProvider extends ChangeNotifier {
  final DataPagingBookmark _dataPagingBookmark = DataPagingBookmark();

  DataPagingBookmark get dataPagingBookmark {
    return _dataPagingBookmark;
  }

  void updateBookmarks(List<NewsBookmarkItemModel> bookmarks) {
    notifyListeners();
  }

  void removeNewsBookmark(int id) {
    _dataPagingBookmark.items?.removeWhere((item) => item.id == id);
    removeNewsBookmarkApi(id);
    notifyListeners();
  }

  void addNewsBookmark(dynamic newsItems) {
    _dataPagingBookmark.items?.add(newsItems);
    addNewsBookmarkApi(newsItems.id);
    notifyListeners();
  }

  // void concatNewsBookmarks(List<NewsBookmarkItemModel> newsBookmarks) {
  //    _dataPagingBookmark.
  //   notifyListeners();
  // }

  Future<void> providerGetListBookmarks(Map<String, dynamic> params) async {
    final paging = _dataPagingBookmark.paging;
    // if the first time -> get the list
    if (paging == null || paging.page == 1) {
      final response = await getNewsletterBookmarks(params: params);
      if (response != null) {
        _dataPagingBookmark.items = response.items;
        _dataPagingBookmark.paging = response.paging;

        notifyListeners();
      }
      return;
    }
    // if the second time -> compare page with total page
    if (paging.page! > paging.totalPage!) {
      return;
    }

    // concat result with previous items
    final response = await getNewsletterBookmarks(params: params);
    final itemsFetched = response?.items ?? [];
    _dataPagingBookmark.items!.addAll(itemsFetched);
    _dataPagingBookmark.paging = response!.paging;
    notifyListeners();
  }
}
