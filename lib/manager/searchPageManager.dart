import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:krt_db/common/api.dart';
import 'package:krt_db/common/tools.dart';
import 'package:krt_db/configs.dart';

class SearchPageManager with ChangeNotifier {
  var _result;
  var _parsed;
  List _searchDataList = [];
  UnmodifiableListView get searchDataList =>
      UnmodifiableListView(_searchDataList);
  int get searchDataTotal => _searchDataList.length;
  bool _searchInputEmpty = true;
  bool get searchInputEmpty => _searchInputEmpty;
  String _inputText = '';
  String get inputText => _inputText;
  final GlobalKey<FormState> sendTextKey = GlobalKey<FormState>();
  final TextEditingController sendText = TextEditingController();
  Map<String, dynamic> _parameters = {
    "name": "",
    "job_number": "",
    "ID_number": "",
    "mobile_phone_number": ""
  };

  SearchPageManager() {}
  //type = 0 name
  //type = 1 job_number
  //type = 2 ID_number
  //type = 3 mobile_phone_number
  querySearchData(int type) async {
    if (sendText.text.isNotEmpty) {
      _searchDataList.clear();
      _parameters = {
        "name": "",
        "job_number": "",
        "ID_number": "",
        "mobile_phone_number": ""
      };
      if (type == 0)
        _parameters['name'] = sendText.text;
      else if (type == 1)
        _parameters['job_number'] = sendText.text;
      else if (type == 2)
        _parameters['ID_number'] = sendText.text;
      else if (type == 3) _parameters['mobile_phone_number'] = sendText.text;
      Response response = await Api.queryUsersData(_parameters);
      if (response.statusCode == 200) {
        _result = response.data ?? null;
        _parsed = json.decode(_result);
        if (_parsed['code'] == "00") {
          print("DEBUG=> ${_parsed['data']}");
          _searchDataList = _parsed['data'] ?? null;
          notifyListeners();
        } else {
          showToast('服务出错，请联系老公!');
        }
      } else {
        showToast('网络错误，请联系老公!!');
      }
    } else {
      showToast('搜索内容不能为空');
    }
  }

  @override
  void dispose() {
    sendText.dispose();
    super.dispose();
  }
}
