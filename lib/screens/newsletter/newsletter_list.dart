import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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

class NewsletterListScreen extends StatefulWidget {
  const NewsletterListScreen({super.key});

  @override
  State<NewsletterListScreen> createState() => NewsletterListState();
}

class NewsletterListState extends State<NewsletterListScreen> {
  // late Future<DataPagingList?> newsletterList;
  late List<NewsItems> newsletterList = [];
  int currentPage = 1;
  final int limit = 10;
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
                      const Text('ajhdf'),
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
                            // return Container(
                            //   decoration: BoxDecoration(
                            //     border: Border.all(
                            //         color:
                            //             categoryUnselectedBorderColor),
                            //     borderRadius:
                            //         BorderRadius.all(
                            //             Radius.circular(8)),
                            //   ),
                            //   child: TextButton(
                            //       onPressed: () {},
                            //       child: Text(
                            //         category.label,
                            //         style: const TextStyle(
                            //           color: Colors.black,
                            //         ),
                            //       )),
                            // );
                          }).toList(),
                        ),
                      ),
                      // ListView.builder(itemBuilder: (context, constraints) {
                      //   return ElevatedButton(
                      //       onPressed: () {},
                      //       child: Text(category.label),
                      //     )
                      // }),
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

  bool isBookmark = false;

  @override
  Widget build(BuildContext context) {
    // return ListView.builder(itemBuilder: ((context, index) {
    //   final newsletterItem = newsletterList[index];
    //   return Container(
    //     decoration: BoxDecoration(
    //         border: Border.all(),
    //         borderRadius: const BorderRadius.all(Radius.circular(8))),
    //     child: Text('${newsletterItem.title}'),
    //   );
    // }));
    // return FutureBuilder(future: newsletterList, builder: (context, snapshot){
    //   if (snapshot.connectionState == ConnectionState.waiting) {
    //         return Center(child: CircularProgressIndicator());
    //       } else if (snapshot.hasError) {
    //         return Center(child: Text('Error: ${snapshot.error}'));
    //       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
    //         return Center(child: Text('No data available'));
    //       } else {

    //       }
    // })

    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 56,
        title: const Text('뉴스레터'),
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset('assets/icons/newsletter/bookmark_list.png'),
          onPressed: () {
            context.pushNamed('NewsletterBookmarkScreen');
          },
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/icons/newsletter/search.png'),
            onPressed: () {
              context.pushNamed('NewsletterBookmarkScreen');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              width: width,
              margin: const EdgeInsets.only(top: 16, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DropdownCustom(
                    selectMenuItem: (menuValue) {
                      resetDataWithSort(menuValue);
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 16),
                    width: 44,
                    height: 44,
                    child: IconButton(
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            side: const BorderSide(color: Colors.black)),
                        onPressed: _openBottomModal,
                        icon: Image.asset(
                          'assets/icons/newsletter/filter.png',
                        )),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                itemCount: newsletterList.length,
                itemBuilder: (context, index) {
                  final item = newsletterList[index];
                  return Container(
                    key: ValueKey(item.image),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: borderColor),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        context.pushNamed('NewsletterDetailScreen',
                            extra: jsonEncode(item));
                      },
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
                                height: width * 2 / 3,
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
                                      fontSize: 24,
                                    )),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Container(
          //   margin: const EdgeInsets.only(top: 20),
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.grey[400]!,
          //         blurRadius: 2.0,
          //       ),
          //     ],
          //   ),
          //   child: IconButton(
          //     style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
          //     icon: Image.asset('assets/icons/newsletter/scroll_up.png'),
          //     onPressed: () {
          //       // setState(() {
          //       //   isBookmark = !isBookmark;
          //       // });
          //       scrollController.animateTo(0,
          //           duration: Duration(milliseconds: 500),
          //           curve: Curves.linear);
          //     },
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400]!,
                  blurRadius: 2.0,
                ),
              ],
            ),
            child: IconButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              selectedIcon:
                  Image.asset('assets/icons/newsletter/bookmark_enable.png'),
              isSelected: isBookmark,
              icon: Image.asset('assets/icons/newsletter/bookmark.png'),
              onPressed: () {
                setState(() {
                  isBookmark = !isBookmark;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
