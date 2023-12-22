import 'package:flutter/material.dart';
import 'package:flutter_mildang/apis/newsletter.api.dart';
import 'package:flutter_mildang/model/newsletter_list_model.dart';
import 'package:flutter_mildang/provider/newsletter_bookmark_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsletterDetailScreen extends StatefulWidget {
  const NewsletterDetailScreen({super.key, required this.newsItems});
  final NewsItems newsItems;

  @override
  State<NewsletterDetailScreen> createState() => NewsletterDetailState();
}

class NewsletterDetailState extends State<NewsletterDetailScreen> {
  bool isBookmark = false;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // isBookmark = widget.newsItems.isBookmark ?? false;
    fetchDetailNewsletter();
  }

  void fetchDetailNewsletter() async {
    final detail = await getNewsletterDetail(widget.newsItems.id!);
    setState(() {
      isBookmark = detail?.isBookMark ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('isBookmark $isBookmark');
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadHtmlString(
          '\'\'${widget.newsItems.content}${widget.newsItems.content}\'\'');
    return Scaffold(
      appBar: AppBar(
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
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: WebViewWidget(controller: controller),
            ),
          ),
        ],
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
                // setState(() {
                //   isBookmark = !isBookmark;
                // });
                // scrollController.animateTo(0,
                //     duration: Duration(milliseconds: 500),
                //     curve: Curves.linear);
                controller.scrollTo(0, 0);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16),
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
                if (!isBookmark) {
                  // add
                  Provider.of<NewsletterBookmarkProvider>(context,
                          listen: false)
                      .addNewsBookmark(widget.newsItems);
                } else {
                  Provider.of<NewsletterBookmarkProvider>(context,
                          listen: false)
                      .removeNewsBookmark(widget.newsItems.id!);
                }
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

class Webview extends StatelessWidget {
  const Webview({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadHtmlString('\'\'$content\'\'');
    return WebViewWidget(controller: controller);
  }
}
