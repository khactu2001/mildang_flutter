// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mildang/model/authen_model.dart';
// import 'package:flutter_mildang/apis/api.dart';
import 'package:flutter_mildang/model/change_notifier_model.dart';
import 'package:flutter_mildang/my_material.dart';
import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChangeNotifierModel()),
        ChangeNotifierProvider(create: (context) => AuthenModel()),
      ],
      child: MyMaterial(),
    ),
  );
}
