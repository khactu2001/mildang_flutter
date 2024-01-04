import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends AppBar {
  // CustomAppBar({super.key});
  CustomAppBar({
    Key? key,
    this.onPressRightIcon,
    this.isTransparent = true,
    String? title,
    Color? backgroundColor,
    List<Widget>? actions,
  }) : super(
            key: key,
            title: Text(
              title ?? '',
            ),
            backgroundColor:
                isTransparent == true ? Colors.transparent : backgroundColor,
            elevation: isTransparent == true ? 0 : 1,
            actions: [
              onPressRightIcon == null
                  ? Container()
                  : IconButton(
                      onPressed: onPressRightIcon,
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Colors.black,
                      ),
                    ),
            ],
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Get.back();
              },
            )
            // actions: actions,
            );

  final Function()? onPressRightIcon;
  final bool? isTransparent;
}
