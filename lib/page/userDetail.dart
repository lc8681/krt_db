import 'package:flutter/material.dart';
import 'package:krt_db/manager/searchPageManager.dart';
import 'package:provider/provider.dart';

class UserDetailPage extends StatefulWidget {
  UserDetailPage({Key key, this.userMap}) : super(key: key);
  final Map userMap;

  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetailPage> {
  List<String> keyList = [
    "人员类别",
    "员工编号",
    "人员状态",
    "姓名",
    "身份证号码",
    "出生年月",
    "年龄",
    "民族",
    "性别",
    "政治面貌",
    "籍贯",
    "婚姻状况",
    "实习类别",
    "来源分类",
    "所在部门",
    "部门全称",
    "入职日期",
    "司龄",
    "参加工作时间",
    "工龄",
    "岗位序列",
    "岗位工时",
    "劳动合同所属公司",
    "劳动合同起始日期",
    "劳动合同终止日期",
    "劳动合同2008年后签订次数",
    "劳动合同类型",
    "职级类别",
    "返聘协议起始日期",
    "返聘协议终止日期",
    "实习协议起始日期",
    "实习协议终止日期",
    "岗位名称",
    "任职类型",
    "职称名称",
    "职称级别",
    "技能等级",
    "最高学历",
    "最高学位",
    "所学专业",
    "毕业院校",
    "毕业日期",
    "电子邮箱",
    "家庭住址（详细）",
    "手机号码",
    "紧急联系人姓名",
    "紧急联系人电话",
    "紧急联系人与本人关系",
    "户口所在地",
    "体检情况",
    "竞业禁止协议标识",
    "档案所在地",
    "档案是否在公司",
    "长期服务标识",
    "身份证上地址",
    "股权激励",
    "班车",
    "考勤方式",
    "社保所属公司",
    "户口性质",
    "开始缴纳社保日期",
    "保险缴纳类别",
    "社保缴费年限",
    "参加养老标识",
    "参加公积金标识",
    "保险代理公司",
    "公积金个人编号",
    "社保基数",
    "公积金基数",
    "险种缴纳地",
    "薪资所属公司",
    "工资归属部门",
    "工资一级部门",
    "工资二级部门",
    "工资三级部门",
    "银行名称",
    "开户行名称",
    "工资账号",
    "参与考核",
    "所属工资套",
    "哺乳补贴开始日期",
    "哺乳补贴结束日期",
    "加班预存标识",
    "加班小时上限",
    "综合工时预存上限",
    "离职类别",
    "离职原因",
    "最后工作日",
    "提前转正期限（月）",
    "异动类型",
    "试用期开始日期",
    "产假开始日期",
    "产假结束日期",
    "实习转试用日期",
    "试用期期限（月）",
    "转正时间",
    "变动前原职级",
    "异动日期",
    "板块名称",
    "二级部门",
    "三级部门",
    "四级部门",
    "产假应休天数",
    "已休年假",
    "哺乳补贴基数",
    "司龄（月）",
    "原部门",
    "原岗位名称",
    "兼任信息",
    "招聘来源",
    "招聘类型"
  ];

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.userMap['姓名']),
        ),
        body: Container(
          padding: const EdgeInsets.all(15.0),
          child: _detailListView(),
        ));
  }

  Widget _detailListView() {
    Map _userMapBase = widget.userMap;
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(
              height: 1.0,
              thickness: 1.0,
              color: Colors.grey[200],
            ),
        shrinkWrap: true,
        itemCount: keyList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('${keyList[index]}：',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 19.0)),
                  Expanded(
                      child: SelectableText(
                    _userMapBase[keyList[index]] != null
                        ? '${_userMapBase[keyList[index]]}'
                        : '',
                    style: TextStyle(fontSize: 17.0),
                  )),
                ],
              ));
        });
  }
}
