import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppUtil{
static const String baseUrl = 'https://e-commerce-server-zc33.onrender.com/api';

static const String signUP = '$baseUrl/users/register';
static const String login = '$baseUrl/users/login';

  static void showToast(String s) {
    Fluttertoast.showToast(
        msg: s,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}