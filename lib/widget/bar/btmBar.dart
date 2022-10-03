import 'package:clindar_mobile/theme/light_colors.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
