// import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_mildang/apis/api.dart';
import 'package:flutter_mildang/model/login_model.dart';
import 'package:flutter_mildang/my_material.dart';
import 'package:flutter_mildang/provider/authen_provider.dart';
import 'package:flutter_mildang/provider/change_notifier_provider.dart';
import 'package:flutter_mildang/provider/newsletter_bookmark_model.dart';
import 'package:flutter_mildang/utils/utilities.dart';
import 'package:provider/provider.dart';

// import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Map<String, dynamic>? token =
      await getLocalVariable(LocalKeyCustom.token);
  final Map<String, dynamic>? userCheck =
      await getLocalVariable(LocalKeyCustom.user);
  print('user loaded from local: $userCheck');
  print('token loaded from local: $token');
  bool isLoggedIn = false;

  TokenModel? tokenModel;
  if (userCheck != null && token != null) {
    isLoggedIn = true;
    tokenModel = TokenModel.fromJson(token);
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
