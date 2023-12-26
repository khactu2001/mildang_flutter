import 'package:flutter/material.dart';
import 'package:flutter_mildang/apis/newsletter.api.dart';
import 'package:flutter_mildang/model/newsletter_bookmarks_model.dart';

abstract class Identifier {
  int get id;
}

// abstract class Provider {
//   List<T> get items;
// }
class NewsGenericType {
  NewsGenericType(this.item);

  NewsGenericType item;

  // @override
  int get id {
    return item.id;
  }

  int getNumber() {
    return 13;
  }
}

class NewsletterBookmarkProvider extends ChangeNotifier {
  DataPagingBookmark _dataPagingBookmark = DataPagingBookmark();
  DataPagingBookmarkGeneric _dataPagingBookmarkGeneric =
      DataPagingBookmarkGeneric();
  // List<T> _list = [];

  void updateBookmarks(List<NewsGenericType> bookmarks) {
    // _list = bookmarks;
    notifyListeners();
  }

  void removeNewsBookmark(int id) {
    // _dataPagingBookmark.items?.removeWhere((item) => item.id == id);
    _dataPagingBookmarkGeneric.items?.removeWhere((item) => item.id == id);
    notifyListeners();
    removeNewsBookmarkApi(id);
    // ----
    // _list.removeWhere((item) => item.id == id);
  }

  void addNewsBookmark(NewsGenericType newsItems) {
    // _dataPagingBookmark.items?.add(newsItems);
    // _dataPagingBookmarkGeneric.items?.add(newsItems);
    notifyListeners();
    // newsItems.
    // NewsGenericType newsGenericType = NewsGenericType(newsItems);

    print(newsItems.getNumber());

    // addNewsBookmarkApi(item.get);
    // _list.add(newsItems);
  }

  void concatNewsBookmarks(List<NewsGenericType> newsBookmarks) {
    // _list.addAll(newsBookmarks);
    notifyListeners();
  }

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
      _dataPagingBookmarkGeneric = DataPagingBookmarkGeneric(
          items: response.items?.cast(), paging: response.paging);
      updateBookmarks(response.items?.cast() ?? []);
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

    _dataPagingBookmarkGeneric = DataPagingBookmarkGeneric(
        items: response.items?.cast(), paging: response.paging);

    concatNewsBookmarks(itemsFetched.cast());
    //

    notifyListeners();
  }
}
