import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mildang/apis/newsletter.api.dart';
import 'package:flutter_mildang/configs/theme.config.dart';
// import 'package:flutter_mildang/apis/newsletter.api.dart';
import 'package:flutter_mildang/model/newsletter_list_model.dart';
import 'package:flutter_mildang/widgets/dropdown-menu/dropdown_menu_custom.dart';
import 'package:go_router/go_router.dart';

// class NewsletterListScreen extends StatelessWidget {
//   const NewsletterListScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Text('Newsletter List');
//   }
// }

class Category {
  Category({
    required this.label,
    required this.value,
  });
  final String label;
  final String value;
}

final List<Category> categories = [
  Category(label: 'cate 111111', value: '1'),
  Category(label: 'cate 2', value: '2'),
  Category(label: 'cate 3444444', value: '3'),
  Category(label: 'cate 444', value: '4'),
  Category(label: 'cate 544', value: '5'),
  Category(label: 'cate 64', value: '6'),
  Category(label: 'cate 7', value: '7'),
  Category(label: 'cate 8098345983945', value: '8'),
];

class NewsletterBookmarkScreen extends StatefulWidget {
  const NewsletterBookmarkScreen({super.key});

  @override
  State<NewsletterBookmarkScreen> createState() => NewsletterListState();
}

class NewsletterListState extends State<NewsletterBookmarkScreen> {
  // late Future<DataPagingList?> newsletterList;
  late List<NewsItems> newsletterList = [];
  int currentPage = 1;
  final int limit = 20;
  int total = 0;
  int totalPage = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // getNewsletterDetail(13094);
    fetchData({
      'page': currentPage,
      'limit': limit,
    });
  }

  void _loadMore() {
    if (currentPage >= totalPage) return;
    currentPage += 1;
    fetchData({
      'page': currentPage,
      'limit': limit,
    });
  }

  void _onScroll() {
    final position = _scrollController.position;
    if (position.pixels == position.maxScrollExtent) {
      _loadMore();
    }
  }

  void resetDataWithSort(String sortType) {
    currentPage = 1;
    Map<String, dynamic> queryParams = {
      'page': currentPage,
      'limit': limit,
    };
    if (sortType == 'DESC' || sortType == 'ASC') {
      queryParams.addAll({
        'sort[issueDate]': sortType,
      });
    } else {
      queryParams.addAll({
        'sort[likeCount]': 'DESC',
      });
    }

    fetchData(queryParams);
  }

  Future fetchData(Map<String, dynamic> params) async {
    DataPagingList? dataPagingList = await getNewsletters(params: params);
    total = dataPagingList?.paging?.total ?? 0;
    totalPage = dataPagingList?.paging?.totalPage ?? 0;
    if (dataPagingList == null) return;
    setState(() {
      if (currentPage == 1) {
        newsletterList = [];
      }
      newsletterList.addAll(dataPagingList.items ?? []);
    });
  }

  final ScrollController _scrollController = ScrollController();

  void _openBottomModal() {
    showDialog(
        context: context,
        builder: (context) {
          return LayoutBuilder(builder: ((context, constraints) {
            return SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Column(children: [
                  Expanded(
                    child: Container(),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(children: [
                      const Text('카테고리'),
                      SizedBox(
                        width: double.infinity,
                        child: Wrap(
                          runSpacing: 16,
                          spacing: 12,
                          children: categories.map((category) {
                            return OutlinedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 10,
                                ),
                                backgroundColor: categoryUnselectedColor,
                                side: BorderSide(
                                  width: 1,
                                  color: categoryUnselectedBorderColor,
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                category.label,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel')),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Ok')),
                        ],
                      )
                    ]),
                  ),
                ]));
          }));
        });
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final itemWidth = MediaQuery.of(context).size.width / 2 - 6;
    const ratio = 170 / 209;
    final itemHeight = itemWidth / ratio;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 56,
        title: const Text('Bookmark Screen'),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/icons/newsletter/filter.png'),
            onPressed: _openBottomModal,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                  controller: _scrollController,
                  addAutomaticKeepAlives: true,
                  padding: const EdgeInsets.all(0),
                  itemCount: newsletterList.isEmpty ? 0 : newsletterList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 12,
                    childAspectRatio: ratio,
                  ),
                  itemBuilder: (context, index) {
                    if (newsletterList.isEmpty) return null;
                    final item = newsletterList[index];
                    return InkWell(
                      onTap: () {
                        context.pushNamed('NewsletterDetailScreen',
                            extra: jsonEncode(item));
                      },
                      child: Container(
                        key: ValueKey(item.image),
                        decoration: BoxDecoration(
                          border: Border.all(color: borderColor),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (item.image != null)
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: item.image ?? '',
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(
                                    strokeWidth: 1,
                                  ),
                                  height: itemHeight * 113 / 209,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              child: Text(item.title ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontSize: 20,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
