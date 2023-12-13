class NewsletterListResponse {
  bool? status;
  String? message;
  DataPagingList? data;

  NewsletterListResponse({this.status, this.message, this.data});

  NewsletterListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? new DataPagingList.fromJson(json['data']) : null;
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

class DataPagingList {
  List<Items>? items;
  Paging? paging;

  DataPagingList({this.items, this.paging});

  DataPagingList.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
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

class Items {
  String? createdAt;
  String? updatedAt;
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
  List<Tags>? tags;
  Pushnotification? pushnotification;
  int? bookmarkCount;
  int? likeCount;
  int? unlikeCount;
  bool? isBookmark;
  bool? isLike;
  bool? isUnlike;
  int? imageWidth;
  int? imageHeight;

  Items(
      {this.createdAt,
      this.updatedAt,
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
      this.tags,
      this.pushnotification,
      this.bookmarkCount,
      this.likeCount,
      this.unlikeCount,
      this.isBookmark,
      this.isLike,
      this.isUnlike,
      this.imageWidth,
      this.imageHeight});

  Items.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(new Tags.fromJson(v));
      });
    }
    pushnotification = json['pushnotification'] != null
        ? new Pushnotification.fromJson(json['pushnotification'])
        : null;
    bookmarkCount = json['bookmarkCount'];
    likeCount = json['likeCount'];
    unlikeCount = json['unlikeCount'];
    isBookmark = json['isBookmark'];
    isLike = json['isLike'];
    isUnlike = json['isUnlike'];
    imageWidth = json['imageWidth'];
    imageHeight = json['imageHeight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
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
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    if (this.pushnotification != null) {
      data['pushnotification'] = this.pushnotification!.toJson();
    }
    data['bookmarkCount'] = this.bookmarkCount;
    data['likeCount'] = this.likeCount;
    data['unlikeCount'] = this.unlikeCount;
    data['isBookmark'] = this.isBookmark;
    data['isLike'] = this.isLike;
    data['isUnlike'] = this.isUnlike;
    data['imageWidth'] = this.imageWidth;
    data['imageHeight'] = this.imageHeight;
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

class Tags {
  String? createdAt;
  String? updatedAt;
  int? id;
  String? type;
  String? name;
  bool? recommend;
  bool? isActive;

  Tags(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.type,
      this.name,
      this.recommend,
      this.isActive});

  Tags.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    type = json['type'];
    name = json['name'];
    recommend = json['recommend'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;
    data['recommend'] = this.recommend;
    data['isActive'] = this.isActive;
    return data;
  }
}

class Pushnotification {
  String? createdAt;
  String? updatedAt;
  int? id;
  String? title;
  String? bigThumnail;
  String? largeIcon;
  String? filename;
  String? pushTitle;
  String? pushContent;
  String? pushStatus;
  String? pushDate;
  String? pushTime;
  String? pushType;
  bool? age10;
  bool? age20;
  bool? age30;
  bool? age40;
  bool? age50;
  bool? age60;
  bool? genderMale;
  bool? genderFemale;
  bool? entire;
  bool? diabetesType1;
  bool? diabetesType2;
  bool? preDiabetes;
  bool? underHealthCare;
  bool? diabeticFamily;
  bool? etc;
  bool? annouce;
  bool? event;
  String? redirectType;
  String? redirectLink;
  bool? isSent;
  String? pushTimeUTC;

  Pushnotification(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.title,
      this.bigThumnail,
      this.largeIcon,
      this.filename,
      this.pushTitle,
      this.pushContent,
      this.pushStatus,
      this.pushDate,
      this.pushTime,
      this.pushType,
      this.age10,
      this.age20,
      this.age30,
      this.age40,
      this.age50,
      this.age60,
      this.genderMale,
      this.genderFemale,
      this.entire,
      this.diabetesType1,
      this.diabetesType2,
      this.preDiabetes,
      this.underHealthCare,
      this.diabeticFamily,
      this.etc,
      this.annouce,
      this.event,
      this.redirectType,
      this.redirectLink,
      this.isSent,
      this.pushTimeUTC});

  Pushnotification.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    title = json['title'];
    bigThumnail = json['bigThumnail'];
    largeIcon = json['largeIcon'];
    filename = json['filename'];
    pushTitle = json['pushTitle'];
    pushContent = json['pushContent'];
    pushStatus = json['pushStatus'];
    pushDate = json['pushDate'];
    pushTime = json['pushTime'];
    pushType = json['pushType'];
    age10 = json['age10'];
    age20 = json['age20'];
    age30 = json['age30'];
    age40 = json['age40'];
    age50 = json['age50'];
    age60 = json['age60'];
    genderMale = json['genderMale'];
    genderFemale = json['genderFemale'];
    entire = json['entire'];
    diabetesType1 = json['diabetesType1'];
    diabetesType2 = json['diabetesType2'];
    preDiabetes = json['preDiabetes'];
    underHealthCare = json['underHealthCare'];
    diabeticFamily = json['diabeticFamily'];
    etc = json['etc'];
    annouce = json['annouce'];
    event = json['event'];
    redirectType = json['redirectType'];
    redirectLink = json['redirectLink'];
    isSent = json['isSent'];
    pushTimeUTC = json['pushTimeUTC'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    data['title'] = this.title;
    data['bigThumnail'] = this.bigThumnail;
    data['largeIcon'] = this.largeIcon;
    data['filename'] = this.filename;
    data['pushTitle'] = this.pushTitle;
    data['pushContent'] = this.pushContent;
    data['pushStatus'] = this.pushStatus;
    data['pushDate'] = this.pushDate;
    data['pushTime'] = this.pushTime;
    data['pushType'] = this.pushType;
    data['age10'] = this.age10;
    data['age20'] = this.age20;
    data['age30'] = this.age30;
    data['age40'] = this.age40;
    data['age50'] = this.age50;
    data['age60'] = this.age60;
    data['genderMale'] = this.genderMale;
    data['genderFemale'] = this.genderFemale;
    data['entire'] = this.entire;
    data['diabetesType1'] = this.diabetesType1;
    data['diabetesType2'] = this.diabetesType2;
    data['preDiabetes'] = this.preDiabetes;
    data['underHealthCare'] = this.underHealthCare;
    data['diabeticFamily'] = this.diabeticFamily;
    data['etc'] = this.etc;
    data['annouce'] = this.annouce;
    data['event'] = this.event;
    data['redirectType'] = this.redirectType;
    data['redirectLink'] = this.redirectLink;
    data['isSent'] = this.isSent;
    data['pushTimeUTC'] = this.pushTimeUTC;
    return data;
  }
}

class Paging {
  int? total;
  int? limit;
  int? totalPage;
  int? page;

  Paging({this.total, this.limit, this.totalPage, this.page});

  Paging.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    limit = json['limit'];
    totalPage = json['totalPage'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['limit'] = this.limit;
    data['totalPage'] = this.totalPage;
    data['page'] = this.page;
    return data;
  }
}
