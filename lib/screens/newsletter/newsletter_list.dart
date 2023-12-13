import 'package:flutter/material.dart';
import 'package:flutter_mildang/apis/newsletter.api.dart';
import 'package:flutter_mildang/model/newsletter_detail_model.dart';

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
  late Future<Data> newsletterList;

  @override
  void initState() {
    super.initState();

    getNewsletterDetail(13094);
  }

  @override
  Widget build(BuildContext context) {
    return const Text('aksjhdfkh');
  }
}
