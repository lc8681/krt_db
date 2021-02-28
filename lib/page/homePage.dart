import 'package:flutter/material.dart';
import 'package:krt_db/manager/searchPageManager.dart';
import 'package:provider/provider.dart';
import 'package:krt_db/page/userDetail.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SearchPageManager(),
        child: Consumer(builder: (BuildContext context,
            SearchPageManager searchPageManager, Widget child) {
          return Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
              ),
              body: _bodyContainer(searchPageManager));
        }));
  }

  Widget _bodyContainer(searchPageManager) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          children: <Widget>[
            _searchContainer(searchPageManager),
            _searchButton(searchPageManager),
            Container(height: 10.0),
            _resultListView(searchPageManager)
          ],
        ),
      ),
    );
  }

  Widget _searchContainer(searchPageManager) {
    return Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 40.0,
            width: MediaQuery.of(context).size.width - 140,
            decoration: BoxDecoration(
              color: Color(0xFFF4F4F4),
              borderRadius: BorderRadius.circular((19.5)), // 圆角度
            ),
            child: TextFormField(
              key: searchPageManager.sendTextKey,
              controller: searchPageManager.sendText,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular((19.5)),
                      borderSide: BorderSide.none),
                  counterText: "",
                  hintText: '输入搜索内容，点击下方按钮搜索',
                  hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
                  contentPadding: const EdgeInsets.only(left: 10.0)),
              autofocus: true,
              maxLines: 1,
            ),
          ),
          Container(width: 10.0),
          RaisedButton(
              child: Text('clear'),
              onPressed: () => searchPageManager.sendText.clear()),
        ],
      ),
    );
  }

  Widget _searchButton(searchPageManager) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      // width: MediaQuery.of(context).size.width - 100.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _searchButtonModel(searchPageManager, '姓名', 0),
          _searchButtonModel(searchPageManager, '工号', 1),
          _searchButtonModel(searchPageManager, '身份证', 2),
          _searchButtonModel(searchPageManager, '手机号', 3)
        ],
      ),
    );
  }

  Widget _searchButtonModel(searchPageManager, String text, int type) {
    return RaisedButton(
      child: Text(text),
      onPressed: () => searchPageManager.querySearchData(type),
    );
  }

  Widget _resultListView(searchPageManager) {
    var baseSearchPageManager = searchPageManager.searchDataList;
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: searchPageManager.searchDataTotal,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserDetailPage(
                          userMap: baseSearchPageManager[index]))),
              child: _listItemView(
                baseSearchPageManager[index]['员工编号'],
                baseSearchPageManager[index]['姓名'],
                baseSearchPageManager[index]['所在部门'],
                baseSearchPageManager[index]['身份证号码'],
                baseSearchPageManager[index]['手机号码'],
                baseSearchPageManager[index]['人员状态'],
              ),
            );
          }),
    );
  }

  Widget _listItemView(int jobNumber, String name, String branch,
      String idNumber, String mobilePhoneNumber, String userStatus) {
    return Card(
        elevation: 1.0,
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SelectableText("工号：${jobNumber.toString()}",
                  style: TextStyle(fontSize: 18.0)),
              SelectableText("姓名：$name", style: TextStyle(fontSize: 18.0)),
              SelectableText("所在部门：$branch", style: TextStyle(fontSize: 18.0)),
              SelectableText("身份证：$idNumber", style: TextStyle(fontSize: 18.0)),
              SelectableText(
                "手机号：$mobilePhoneNumber",
                style: TextStyle(fontSize: 18.0),
              ),
              SelectableText(
                "人员状态：$userStatus",
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ));
  }
}
