import 'package:flutter_mildang/apis/base.api.dart';
import 'package:flutter_mildang/model/category_model.dart';
// import 'package:flutter_mildang/model/category_model.dart';

const String path = 'category';
BaseAPI api = BaseAPI();

Future<CategoryModel?> getCategories({Map<String, dynamic>? params}) async {
  final Map<String, dynamic>? response =
      await api.baseRequestWithToken('GET', path, params: params);
  if (response == null) return null;
  CategoryModel categoryModel = CategoryModel.fromJson(response);
  return categoryModel;
  // TagResponse tagListResponse = TagResponse.fromJson(response);
  // return tagListResponse.data;
}
