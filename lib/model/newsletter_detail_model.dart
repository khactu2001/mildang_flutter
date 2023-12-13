class NewsDetailModel {
  bool? status;
  String? message;
  Data? data;

  NewsDetailModel({this.status, this.message, this.data});

  NewsDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  int? imageWidth;
  int? imageHeight;
  bool? isUnlike;
  bool? isLike;
  bool? isBookMark;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? id;
  String? title;
  String? subTitleTop;
  String? subTitleBottom;
  String? issueNumber;
  String? issueDate;
  String? author;
  String? image;
  bool? exposure;
  String? transmissionStatus;
  String? transmissionDate;
  String? content;
  bool? isActive;
  int? views;
  String? writer;
  String? caption;
  String? source;
  List<Categories>? categories;
  int? bookmarkCount;
  int? likeCount;
  int? unlikeCount;

  Data(
      {this.imageWidth,
      this.imageHeight,
      this.isUnlike,
      this.isLike,
      this.isBookMark,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.id,
      this.title,
      this.subTitleTop,
      this.subTitleBottom,
      this.issueNumber,
      this.issueDate,
      this.author,
      this.image,
      this.exposure,
      this.transmissionStatus,
      this.transmissionDate,
      this.content,
      this.isActive,
      this.views,
      this.writer,
      this.caption,
      this.source,
      this.categories,
      this.bookmarkCount,
      this.likeCount,
      this.unlikeCount});

  Data.fromJson(Map<String, dynamic> json) {
    imageWidth = json['imageWidth'];
    imageHeight = json['imageHeight'];
    isUnlike = json['isUnlike'];
    isLike = json['isLike'];
    isBookMark = json['isBookMark'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    id = json['id'];
    title = json['title'];
    subTitleTop = json['subTitleTop'];
    subTitleBottom = json['subTitleBottom'];
    issueNumber = json['issueNumber'];
    issueDate = json['issueDate'];
    author = json['author'];
    image = json['image'];
    exposure = json['exposure'];
    transmissionStatus = json['transmissionStatus'];
    transmissionDate = json['transmissionDate'];
    content = json['content'];
    isActive = json['isActive'];
    views = json['views'];
    writer = json['writer'];
    caption = json['caption'];
    source = json['source'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    bookmarkCount = json['bookmarkCount'];
    likeCount = json['likeCount'];
    unlikeCount = json['unlikeCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageWidth'] = this.imageWidth;
    data['imageHeight'] = this.imageHeight;
    data['isUnlike'] = this.isUnlike;
    data['isLike'] = this.isLike;
    data['isBookMark'] = this.isBookMark;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['id'] = this.id;
    data['title'] = this.title;
    data['subTitleTop'] = this.subTitleTop;
    data['subTitleBottom'] = this.subTitleBottom;
    data['issueNumber'] = this.issueNumber;
    data['issueDate'] = this.issueDate;
    data['author'] = this.author;
    data['image'] = this.image;
    data['exposure'] = this.exposure;
    data['transmissionStatus'] = this.transmissionStatus;
    data['transmissionDate'] = this.transmissionDate;
    data['content'] = this.content;
    data['isActive'] = this.isActive;
    data['views'] = this.views;
    data['writer'] = this.writer;
    data['caption'] = this.caption;
    data['source'] = this.source;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['bookmarkCount'] = this.bookmarkCount;
    data['likeCount'] = this.likeCount;
    data['unlikeCount'] = this.unlikeCount;
    return data;
  }
}

class Categories {
  String? createdAt;
  String? updatedAt;
  int? id;
  String? name;
  String? image;
  bool? isActive;
  int? userCount;

  Categories(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.name,
      this.image,
      this.isActive,
      this.userCount});

  Categories.fromJson(Map<String, dynamic> json) {
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
