import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mildang/apis/newsletter.api.dart';
import 'package:flutter_mildang/configs/theme.config.dart';
// import 'package:flutter_mildang/apis/newsletter.api.dart';
import 'package:flutter_mildang/model/newsletter_list_model.dart';
import 'package:flutter_mildang/widgets/dropdown-menu/dropdown_menu_custom.dart';
import 'package:flutter_mildang/widgets/dropdown-menu/popup_dropdown_menu.dart';

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
    print(total);
    print(totalPage);
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
    print(params);
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
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            width: width,
            margin: const EdgeInsets.only(top: 48),
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
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          side: const BorderSide(color: Colors.black)),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return LayoutBuilder(
                                  builder: ((context, constraints) {
                                return SizedBox(
                                    height: height / 2,
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
                                          Container(
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                              color: Colors.yellow,
                                            ),
                                            child: Wrap(
                                              runSpacing: 8,
                                              spacing: 8,
                                              children:
                                                  categories.map((category) {
                                                return ElevatedButton(
                                                  onPressed: () {},
                                                  child: Text(category.label),
                                                );
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Cancel')),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Ok')),
                                            ],
                                          )
                                        ]),
                                      ),
                                    ]));
                              }));
                            });
                      },
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
              padding: const EdgeInsets.symmetric(horizontal: 0),
              itemCount: newsletterList.length,
              itemBuilder: (context, index) {
                final item = newsletterList[index];
                return Container(
                  key: ValueKey(item.image),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: borderColor),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  // clipBehavior: Clip.hardEdge,
                  // child: ListTile(
                  //   title: Text('${item.title}'),
                  //   // Other tile configurations as needed
                  // ),
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
