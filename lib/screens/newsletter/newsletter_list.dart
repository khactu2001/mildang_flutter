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

  Future fetchData(Map<String, dynamic> params) async {
    // Future<DataPagingList?> dataPagingList =  getNewsletters();
    DataPagingList? dataPagingList = await getNewsletters(params: params);
    total = dataPagingList?.paging?.total ?? 0;
    totalPage = dataPagingList?.paging?.totalPage ?? 0;
    if (dataPagingList == null) return;
    setState(() {
      newsletterList.addAll(dataPagingList.items ?? []);
    });
  }

  final ScrollController _scrollController = ScrollController();
  // scrollController.

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
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 48),
          // child: PopupDropdownMenu(
          //   selectMenuItem: (menuValue) {},
          // ),
          child: DropdownCustom(
            selectMenuItem: (menuValue) {},
          ),
        ),
        // Expanded(
        //   child: ListView.builder(
        //     controller: _scrollController,
        //     padding: const EdgeInsets.symmetric(horizontal: 20),
        //     itemCount: newsletterList.length,
        //     itemBuilder: (context, index) {
        //       final item = newsletterList[index];
        //       return Container(
        //         key: ValueKey(item.image),
        //         margin: const EdgeInsets.symmetric(vertical: 10),
        //         decoration: BoxDecoration(
        //           border: Border.all(color: borderColor),
        //           borderRadius: BorderRadius.circular(8.0),
        //         ),
        //         // clipBehavior: Clip.hardEdge,
        //         // child: ListTile(
        //         //   title: Text('${item.title}'),
        //         //   // Other tile configurations as needed
        //         // ),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             if (item.image != null)
        //               ClipRRect(
        //                 borderRadius: const BorderRadius.only(
        //                   topLeft: Radius.circular(8),
        //                   topRight: Radius.circular(8),
        //                 ),
        //                 // child: Image.network(
        //                 //   errorBuilder: (context, error, stackTrace) {
        //                 //     return Text('error ${error}');
        //                 //   },
        //                 //   loadingBuilder: (context, widget, imageChunkEvent) {
        //                 //     return const CircularProgressIndicator();
        //                 //   },
        //                 //   item.image ?? '',
        //                 //   height: width * 2 / 3,
        //                 //   width: double.infinity,
        //                 //   fit: BoxFit.cover,
        //                 // ),
        //                 // child:
        //                 //     Stack(alignment: AlignmentDirectional.center, children: [
        //                 //   const Center(
        //                 //       child: CircularProgressIndicator(
        //                 //     strokeWidth: 2,
        //                 //     color: Colors.grey,
        //                 //   )),
        //                 //   // FadeInImage.memoryNetwork(
        //                 //   //   placeholder: kTransparentImage,
        //                 //   //   image: item.image ?? '',
        //                 //   //   height: width * 2 / 3,
        //                 //   //   width: double.infinity,
        //                 //   //   fit: BoxFit.cover,
        //                 //   // ),
        //                 //   CachedNetworkImage(
        //                 //     imageUrl: item.image ?? '',
        //                 //     placeholder: (context, url) =>
        //                 //         CircularProgressIndicator(),
        //                 //     errorWidget: (context, url, error) => Icon(Icons.error),
        //                 //   ),
        //                 // ]),
        //                 child: CachedNetworkImage(
        //                   imageUrl: item.image ?? '',
        //                   placeholder: (context, url) =>
        //                       const CircularProgressIndicator(
        //                     strokeWidth: 1,
        //                   ),
        //                   // errorWidget: (context, url, error) => Icon(Icons.error),
        //                   height: width * 2 / 3,
        //                   width: double.infinity,
        //                   fit: BoxFit.cover,
        //                 ),
        //               ),
        //             Padding(
        //               padding: const EdgeInsets.symmetric(
        //                   vertical: 12, horizontal: 16),
        //               child: Text(item.title ?? '',
        //                   style:
        //                       Theme.of(context).textTheme.titleLarge?.copyWith(
        //                             fontSize: 24,
        //                           )),
        //             ),
        //           ],
        //         ),
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
