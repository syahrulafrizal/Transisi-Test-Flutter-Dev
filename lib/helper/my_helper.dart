import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'constants.dart';

class MyHelpers {
  static Future<bool> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  static setString(String key, String value) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: key, value: value);
  }

  static getString(String key) async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: key) ?? "";
  }

  static clearAllData() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }

  static clearData(String key) async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: key);
  }

  static Route createRouting(destination) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destination,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static bool validateEmail(String str) {
    final validCharacters = RegExp(
      "^([0-9a-zA-Z]([-.+\\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\\w]*[0-9a-zA-Z]\\.)+[a-zA-Z]{2,9})\$",
    );
    if (str == "") {
      return false;
    }
    return validCharacters.hasMatch(str);
  }

  static renderDivider({
    Color color = const Color(0xFFDEDEDE),
    double height = 1,
  }) {
    return Container(
      height: height,
      color: color,
    );
  }

  static setStatusBar({Color color = Constants.STATUS_BAR_COLOR}) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: color,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
  }
}
