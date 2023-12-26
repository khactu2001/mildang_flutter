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

  NewsBookmarkItemModel.fromJson(Map<String, dynamic> json) {
    imageWidth = json['imageWidth'];
    imageHeight = json['imageHeight'];
    isBookMark = json['isBookMark'];
    id = json['id'];
    title = json['title'];
    image = json['image'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageWidth'] = this.imageWidth;
    data['imageHeight'] = this.imageHeight;
    data['isBookMark'] = this.isBookMark;
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['content'] = this.content;
    return data;
  }
}
