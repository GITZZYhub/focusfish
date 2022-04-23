import 'package:common/theme/theme_provider.dart';
import 'package:common/utils/init_util.dart';
import 'package:common/widgets/public_widget.dart';
import 'package:flutter/material.dart';
import 'package:getx/getx.dart';
import 'package:localization/localization.dart';
import 'package:resources/resources.dart';

import '../../home.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(final BuildContext context) => MyTabController(
        controller: controller,
      );
}

class MyTabController extends StatefulWidget {
  const MyTabController({
    final Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  MyTabControllerState createState() => MyTabControllerState();
}

class MyTabControllerState extends State<MyTabController>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: widget.controller.tabs.length,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        backgroundColor: ThemeProvider.themeBackgroundColor.value,
        appBar: AppBar(
          elevation: 0,
          bottom: TabBar(
            controller: _tabController,
            tabs: widget.controller.tabs
                .map(
                  (
                    final label,
                  ) =>
                      Tab(
                    child: Obx(
                      () => Text(
                        label,
                        style: TextStyle(
                          fontSize: widget.controller.tabIndex.value ==
                                  widget.controller.tabs.indexOf(label)
                              ? bodyText2
                              : caption,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
            isScrollable: true,
            indicator: const BoxDecoration(),
            labelPadding: EdgeInsets.all(dim14w),
          ),
        ),
        drawer: MyDrawer(
          controller: widget.controller,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              NotificationListener(
                onNotification: (final scrollNotification) {
                  // print('$scrollNotification');
                  if (scrollNotification is ScrollUpdateNotification) {
                    final progress = scrollNotification.metrics.pixels /
                        scrollNotification.metrics.maxScrollExtent;
                    debugPrint(progress.toString());
                    final gapCount = widget.controller.tabs.length - 1;
                    widget.controller.tabIndex.value =
                        (progress + (1 / gapCount * 0.5)) ~/ (1 / gapCount);
                  }
                  return true;
                },
                child: TabBarView(
                  controller: _tabController,
                  children: widget.controller.tabs
                      .map(
                        (final e) => KeepAliveWrapper(
                          child: Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: dim100h,
                              ),
                              child: GetImage.getAssetsImage(
                                widget.controller
                                    .tabImgs[widget.controller.tabs.indexOf(e)],
                                width: MediaQuery.of(context).size.width * 0.7,
                                height: MediaQuery.of(context).size.width * 0.7,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: dim200h),
                  child: ElevatedButton(
                    onPressed: clickDebounce.clickDebounce(() {
                      widget.controller.gotoFocusPage();
                    }),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(dim200w, dim200h),
                      shape: const CircleBorder(),
                    ),
                    child: const Text('专注'),
                  ),
                ),
              )
            ],
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
