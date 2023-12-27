import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_mildang/model/newsletter_list_model.dart';

part 'newsletter_bookmark_item_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NewsBookmarkItemModel {
  int? imageWidth;
  int? imageHeight;
  bool? isBookMark;
  int? id;
  String? title;
  String? image;
  String? content;

  NewsBookmarkItemModel({
    this.imageWidth,
    this.imageHeight,
    this.isBookMark,
    this.id,
    this.title,
    this.image,
    this.content,
  });

  factory NewsBookmarkItemModel.fromJson(Map<String, dynamic> json) =>
      _$NewsBookmarkItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$NewsBookmarkItemModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DataPagingBookmark {
  List<NewsBookmarkItemModel>? items;
  Paging? paging;

  DataPagingBookmark({this.items, this.paging});

  factory DataPagingBookmark.fromJson(Map<String, dynamic> json) =>
      _$DataPagingBookmarkFromJson(json);
  Map<String, dynamic> toJson() => _$DataPagingBookmarkToJson(this);
}

// abstract a class with toJson & fromJson methods

