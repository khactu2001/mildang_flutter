import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mildang/apis/category.api.dart';
import 'package:flutter_mildang/apis/newsletter.api.dart';
import 'package:flutter_mildang/configs/theme.config.dart';
import 'package:flutter_mildang/main.dart';
import 'package:flutter_mildang/model/category_model.dart';
import 'package:flutter_mildang/model/newsletter_list_model.dart';
import 'package:flutter_mildang/widgets/dropdown-menu/dropdown_menu_custom.dart';
import 'package:get/get.dart';

class Category {
  Category({
    required this.label,
    required this.value,
  });
  final String label;
  final String value;
}

class NewsletterListScreen extends StatefulWidget {
  const NewsletterListScreen({super.key});

  @override
  State<NewsletterListScreen> createState() => NewsletterListState();
}

class NewsletterListState extends State<NewsletterListScreen> {
  late List<NewsItems> newsletterList = [];
  late List<CategoryItem> categories = [];
  List<int> selectedCategoryIds = [2, 7, 8];
  int currentPage = 1;
  final int limit = 10;
  int total = 0;
  int totalPage = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    fetchData({
      'page': currentPage,
      'limit': limit,
    });
    initCategories();
  }

  void initCategories() async {
    final CategoryModel? categoriesFetched = await getCategories();
    categories = categoriesFetched?.data ?? [];
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

  void _openBottomModal() {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: ((BuildContext context, StateSetter setState) {
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
                            if (selectedCategoryIds.contains(category.id)) {
                              return SizedBox(
                                // width:,
                                height: 54,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 10,
                                    ),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                      side: BorderSide.none,
                                    ),
                                  ),
                                  onPressed: () {
                                    final removedList = selectedCategoryIds;
                                    removedList.remove(category.id);

                                    setState(() {
                                      selectedCategoryIds = removedList;
                                    });
                                  },
                                  child: Text(
                                    category.name ?? '',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return SizedBox(
                              height: 54,
                              child: OutlinedButton(
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
                                onPressed: () {
                                  final addedList = selectedCategoryIds;
                                  addedList.add(category.id!);

                                  setState(() {
                                    selectedCategoryIds = addedList;
                                  });
                                },
                                child: Text(
                                  category.name ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
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
                                Map<String, dynamic> filters = {
                                  'categoryIds': {}
                                };
                                // for (var item in selectedCategoryIds) {
                                //   // filters['categoryIds'][]
                                //   print(item);
                                // }
                                for (var i = 0;
                                    i < selectedCategoryIds.length;
                                    i++) {
                                  filters['categoryIds'][i] =
                                      selectedCategoryIds[i];
                                }

                                print(filters);

                                // target
                                // filters[categoryIds][0]=1 & filters[categoryIds][1]=1 &...
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
    final width = MediaQuery.of(context).size.width;

    Map<String, dynamic> filters = {'categoryIds': {}};
    List<String> filterStringList = [];
    for (var i = 0; i < selectedCategoryIds.length; i++) {
      filters['categoryIds'][i] = selectedCategoryIds[i];
      filterStringList
          .add('filters[categoryIds][$i]=${selectedCategoryIds[i]}');
    }

    print(filters);
    print(filterStringList.join('&'));

    // target
    // filters[categoryIds][0]=1 & filters[categoryIds][1]=1 &...
    final Controller c = Get.find();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 56,
        title: const Text('뉴스레터'),
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset('assets/icons/newsletter/bookmark_list.png'),
          onPressed: () {
            Get.toNamed('/news-bookmark');
          },
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/icons/newsletter/search.png'),
            onPressed: () {
              c.increment();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Obx(() => Text("Clicks: ${c.count}")),
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
                        print('onTapp-------------');
                        Get.toNamed('/news-detail/${item.id}');
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
          Container(
            margin: const EdgeInsets.only(top: 20),
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
              icon: Image.asset('assets/icons/newsletter/scroll_up.png'),
              onPressed: () {
                _scrollController.animateTo(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.linear);
              },
            ),
          ),
        ],
      ),
    );
  }
}
