import 'package:clindar_mobile/theme/light_colors.dart';
import 'package:clindar_mobile/view/group/group.dart';
import 'package:clindar_mobile/view/home.dart';
import 'package:clindar_mobile/view/mypage.dart';
import 'package:clindar_mobile/view/place.dart';
import 'package:clindar_mobile/widget/bar/btmBar.dart';
import 'package:flutter/material.dart';

class HomeTabBar extends StatefulWidget {
  HomeTabBar({Key? key, required this.userInfo, required this.mySchedules})
      : super(key: key);
  Map userInfo;
  List mySchedules;
  @override
  State<HomeTabBar> createState() => _HomeTabBarState();
}

class _HomeTabBarState extends State<HomeTabBar> with TickerProviderStateMixin {
  late TabController _tabController;
  // late int myGroupCount = widget.userInfo['myGroupList'].length;

  // void getNewGroup() {
  //   setState(() {
  //     myGroupCount += 1;
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            body: TabBarView(controller: _tabController, children: [
              HomePage(
                mySchedules: widget.mySchedules,
                userInfo: widget.userInfo,
              ),
              Group(userInfo: widget.userInfo),
              Place(),
              MyPage()
            ]),
            bottomNavigationBar: Container(
              color: LightColors.kDarkYellow,
              child: Container(
                height: 70,
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white60,
                  indicatorColor: Colors.transparent,
                  tabs: [
                    Tab(
                        icon: Icon(
                          Icons.home,
                          size: 20,
                        ),
                        child: Text(
                          '홈',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        )),
                    Tab(
                        icon: Icon(
                          Icons.group,
                          size: 20,
                        ),
                        child: Text(
                          '그룹',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        )),
                    Tab(
                        icon: Icon(
                          Icons.place,
                          size: 20,
                        ),
                        child: Text(
                          '암장',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        )),
                    Tab(
                        icon: Icon(
                          Icons.list,
                          size: 20,
                        ),
                        child: Text(
                          '내 정보',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        )),
                  ],
                ),
              ),
            )));
  }
}
