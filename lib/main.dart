// import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_mildang/apis/api.dart';
import 'package:flutter_mildang/model/login_model.dart';
import 'package:flutter_mildang/my_material.dart';
import 'package:flutter_mildang/provider/authen_provider.dart';
import 'package:flutter_mildang/provider/change_notifier_provider.dart';
import 'package:flutter_mildang/provider/newsletter_bookmark_model.dart';
import 'package:flutter_mildang/utils/utilities.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// import 'package:shared_preferences/shared_preferences.dart';
class Controller extends GetxController {
  var count = 0.obs;
  increment() => count++;

  RxBool isAuthen = false.obs;
  setIsAuthen(bool newAuthen) => isAuthen.value = newAuthen;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Controller c = Get.put(Controller());

  final Map<String, dynamic>? token =
      await getLocalVariable(LocalKeyCustom.token);
  final Map<String, dynamic>? userCheck =
      await getLocalVariable(LocalKeyCustom.user);
  bool isLoggedIn = false;

  TokenModel? tokenModel;
  if (userCheck != null && token != null) {
    isLoggedIn = true;
    tokenModel = TokenModel.fromJson(token);
    // print(tokenModel.toJson());
    c.setIsAuthen(true);
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(
            create: (context) =>
                AuthenProvider(isLoggedIn, tokenModel?.accessToken)),
        ChangeNotifierProvider(
          create: (context) => NewsletterBookmarkProvider(),
        ),
      ],
      child: const MyMaterial(),
    ),
  );
}
