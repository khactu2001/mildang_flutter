// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newsletter_bookmark_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsBookmarkItemModel _$NewsBookmarkItemModelFromJson(
        Map<String, dynamic> json) =>
    NewsBookmarkItemModel(
      imageWidth: json['imageWidth'] as int?,
      imageHeight: json['imageHeight'] as int?,
      isBookMark: json['isBookMark'] as bool?,
      id: json['id'] as int?,
      title: json['title'] as String?,
      image: json['image'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$NewsBookmarkItemModelToJson(
        NewsBookmarkItemModel instance) =>
    <String, dynamic>{
      'imageWidth': instance.imageWidth,
      'imageHeight': instance.imageHeight,
      'isBookMark': instance.isBookMark,
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'content': instance.content,
    };

DataPagingBookmark _$DataPagingBookmarkFromJson(Map<String, dynamic> json) =>
    DataPagingBookmark(
      items: (json['items'] as List<dynamic>?)
          ?.map(
              (e) => NewsBookmarkItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      paging: json['paging'] == null
          ? null
          : Paging.fromJson(json['paging'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataPagingBookmarkToJson(DataPagingBookmark instance) =>
    <String, dynamic>{
      'items': instance.items?.map((e) => e.toJson()).toList(),
      'paging': instance.paging?.toJson(),
    };
