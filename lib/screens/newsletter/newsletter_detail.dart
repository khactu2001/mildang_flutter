import 'package:flutter/material.dart';
import 'package:flutter_mildang/model/newsletter_list_model.dart';
import 'package:go_router/go_router.dart';

class NewsletterDetailScreen extends StatefulWidget {
  const NewsletterDetailScreen({super.key, required this.newsItems});
  final NewsItems newsItems;

  @override
  State<NewsletterDetailScreen> createState() => NewsletterDetailState();
}

class NewsletterDetailState extends State<NewsletterDetailScreen> {
  bool isBookmark = true;

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          color: Colors.black,
        ),
        centerTitle: true,
        title: Text(
          '뉴스레터',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              // context.pop();
            },
            icon: Image.asset('assets/icons/newsletter/share.png'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Text(widget.newsItems.content ?? "No content"),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
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
                // setState(() {
                //   isBookmark = !isBookmark;
                // });
                scrollController.animateTo(0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.linear);
              },
            ),
          ),
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
