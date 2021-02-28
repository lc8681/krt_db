import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:connectivity/connectivity.dart';

Future<void> sharedAddAndUpdate(
    String key, Object dataType, Object data) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  switch (dataType) {
    case bool:
      sharedPreferences.setBool(key, data);
      break;
    case double:
      sharedPreferences.setDouble(key, data);
      break;
    case int:
      sharedPreferences.setInt(key, data);
      break;
    case String:
      sharedPreferences.setString(key, data);
      break;
    case List:
      sharedPreferences.setStringList(key, data);
      break;
    default:
      sharedPreferences.setString(key, data.toString());
      break;
  }
}

Future<Object> sharedGetData(String key) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.get(key);
}

Future sharedDeleteData(String key) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.remove(key);
}

showToast(String title, {Toast toastTime = Toast.LENGTH_SHORT}) {
  Fluttertoast.showToast(
      msg: title,
      toastLength: toastTime,
      gravity: ToastGravity.CENTER,
      backgroundColor: Color(0x99000000),
      textColor: Colors.white,
      fontSize: 12.0);
}

Future<bool> isNetworkConnect() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult != ConnectivityResult.none) {
    return true;
  } else {
    return false;
  }
}
