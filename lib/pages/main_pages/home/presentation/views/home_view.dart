import 'package:common/utils/init_util.dart';
import 'package:common/widgets/public_widget.dart';
import 'package:flutter/material.dart';
import 'package:getx/getx.dart';
import 'package:localization/localization.dart';
import 'package:resources/resources.dart';

import '../../home.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(final BuildContext context) => DefaultTabController(
        length: controller.tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.app_name),
            bottom: TabBar(
              tabs: controller.tabs.map((final e) => Tab(text: e)).toList(),
            ),
          ),
          drawer: MyDrawer(
            controller: controller,
          ),
          body: TabBarView(
            //构建
            children: controller.tabs
                .map(
                  (final e) => KeepAliveWrapper(
                    child: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: dim30w,
                          vertical: dim100h,
                        ),
                        child: Column(
                          children: [
                            GetImage.getSvgImage(R.svg.facebook, size: dim200w),
                            const Spacer(),
                            const Text('25:00'),
                            ElevatedButton(
                              onPressed: clickDebounce.clickDebounce(() {
                                controller.gotoFocusPage();
                              }),
                              child: const Text('专注'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      );
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    final Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(final BuildContext context) => Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: dim38h),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: dim16h),
                      child: ClipOval(
                        child:
                            GetImage.getSvgImage(R.svg.facebook, size: dim100h),
                      ),
                    ),
                    const HeadLine4Text(text: 'Tommy'),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        controller.gotoDailyPage();
                      },
                      child: const ListTile(
                        leading: Icon(Icons.add),
                        title: Text('日报'),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        controller.gotoMyDataPage();
                      },
                      child: const ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('我的数据'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
