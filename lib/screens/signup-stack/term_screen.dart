import 'package:flutter/material.dart';
import 'package:flutter_mildang/model/login_model.dart';
import 'package:flutter_mildang/provider/authen_provider.dart';
import 'package:flutter_mildang/provider/change_notifier_provider.dart';
import 'package:flutter_mildang/utils/utilities.dart';
import 'package:flutter_mildang/widgets/checkbox/custom_checkbox.dart';
import 'package:flutter_mildang/widgets/checkbox/custom_checkbox_row.dart';
import 'package:flutter_mildang/widgets/header/header.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TermScreen extends StatefulWidget {
  const TermScreen({super.key});
  @override
  State<TermScreen> createState() {
    return _TermScreenState();
  }
}

class _TermScreenState extends State<TermScreen> {
  double defaultPadding = 20.0;

  bool isChecked = false;

  @override
  void initState() {
    super.initState();

    // _loadUser();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }
  // get status bar height

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(
        onPressRightIcon: () {
          Get.offNamedUntil('/login', (route) => false);
        },
        title: 'Terms and conditions',
        isTransparent: true,
      ),
      body: SizedBox(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            0,
            defaultPadding + statusBarHeight,
            0,
            defaultPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCheckboxRow(
                isChecked: isChecked,
                onChanged: (p0) {
                  setState(() {
                    isChecked = !isChecked;
                  });
                },
                seeMore: () {},
              ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   crossAxisAlignment: CrossAxisAlignment.stretch,
              //   children: [
              //     Container(
              //       // margin: EdgeInsets.all(8),
              //       child: FloatingActionButton.extended(
              //         onPressed: () {},
              //         label: Text('ahjsdfkhj'),
              //       ),
              //     ),
              //   ],
              // )
              // CustomCheckbox(
              //   isChecked: isChecked,
              //   onChanged: (p0) {
              //     setState(() {
              //       isChecked = !isChecked;
              //     });
              //   },
              //   seeMore: () {},
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
            maximumSize: Size.fromWidth(width - defaultPadding * 2 + 8)),
        child: const Text('lahjsfkjhafd'),
        onPressed: () {
          Get.toNamed('/signup');
        },
      ),
      // floatingActionButton: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   crossAxisAlignment: CrossAxisAlignment.stretch,
      //   children: [
      //     Container(
      //       margin: EdgeInsets.all(8),
      //       width: 200,
      //       decoration: BoxDecoration(color: Colors.amber),
      //       child: FloatingActionButton.small(
      //         onPressed: () {},
      //         child: Text('ahjsdfkhj'),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
