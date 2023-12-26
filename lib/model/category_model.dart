class CategoryItem {
  String? createdAt;
  String? updatedAt;
  int? id;
  String? name;
  String? image;
  bool? isActive;
  int? userCount;

  CategoryItem(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.name,
      this.image,
      this.isActive,
      this.userCount});

  CategoryItem.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    name = json['name'];
    image = json['image'];
    isActive = json['isActive'];
    userCount = json['userCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['isActive'] = this.isActive;
    data['userCount'] = this.userCount;
    return data;
  }
}

class CategoryModel {
  List<CategoryItem>? data;

  CategoryModel({this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CategoryItem>[];
      json['data'].forEach((v) {
        data!.add(CategoryItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
