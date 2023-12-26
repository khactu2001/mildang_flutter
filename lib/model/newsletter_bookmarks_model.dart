import 'package:flutter_mildang/model/newsletter_bookmark_item_model.dart';
import 'package:flutter_mildang/model/newsletter_list_model.dart';

class NewsletterBookmarksResponse {
  bool? status;
  String? message;
  DataPagingBookmark? data;

  NewsletterBookmarksResponse({this.status, this.message, this.data});

  NewsletterBookmarksResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? new DataPagingBookmark.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataPagingBookmark {
  List<NewsBookmarkItemModel>? items;
  Paging? paging;

  DataPagingBookmark({this.items, this.paging});

  DataPagingBookmark.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <NewsBookmarkItemModel>[];
      json['items'].forEach((v) {
        items!.add(new NewsBookmarkItemModel.fromJson(v));
      });
    }
    paging =
        json['paging'] != null ? new Paging.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.paging != null) {
      data['paging'] = this.paging!.toJson();
    }
    return data;
  }
}

class DataPagingBookmarkGeneric<T> {
  List<T>? items;
  Paging? paging;

  DataPagingBookmarkGeneric({this.items, this.paging});

  // DataPagingBookmarkGeneric.fromJson(Map<String, dynamic> json) {
  //   if (json['items'] != null) {
  //     items = <T>[];
  //     json['items'].forEach((v) {
  //       items!.add(new T.fromJson(v));
  //     });
  //   }
  //   paging =
  //       json['paging'] != null ? new Paging.fromJson(json['paging']) : null;
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.items != null) {
  //     data['items'] = this.items!.map((v) => v.toJson()).toList();
  //   }
  //   if (this.paging != null) {
  //     data['paging'] = this.paging!.toJson();
  //   }
  //   return data;
  // }
}
