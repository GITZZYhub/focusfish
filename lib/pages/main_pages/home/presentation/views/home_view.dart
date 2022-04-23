import 'package:carousel_slider/carousel_slider.dart';
import 'package:common/theme/theme_provider.dart';
import 'package:common/utils/init_util.dart';
import 'package:common/widgets/public_widget.dart';
import 'package:common/widgets/spread_widget.dart';
import 'package:flutter/material.dart';
import 'package:getx/getx.dart';
import 'package:resources/resources.dart';

import '../../home.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(final BuildContext context) => Scaffold(
        backgroundColor: ThemeProvider.themeBackgroundColor.value,
        appBar: AppBar(
          elevation: 0,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: dim40w),
              child: Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.deepOrangeAccent,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(dim100w),
                        bottomRight: Radius.circular(dim100w),
                      ),
                    ),
                    margin: EdgeInsets.only(left: dim50w),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: dim30w,
                        top: dim4h,
                        right: dim40w,
                        bottom: dim4h,
                      ),
                      child: Obx(
                        () => Text(
                          controller.coins.value.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  GetImage.getAssetsImage(
                    R.png.coin,
                    height: dim70h,
                    width: dim70w,
                  ),
                ],
              ),
            ),
          ],
        ),
        drawer: MyDrawer(
          controller: controller,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ...Iterable<int>.generate(controller.tabs.length).map(
                        (final pageIndex) => GestureDetector(
                          onTap: () => controller.carouselController
                              .animateToPage(pageIndex),
                          child: Obx(
                            () => Padding(
                              padding: EdgeInsets.all(dim20w),
                              child: Text(
                                controller.tabs[pageIndex],
                                style: TextStyle(
                                  fontSize:
                                      controller.tabIndex.value == pageIndex
                                          ? bodyText2
                                          : caption,
                                  color: controller.tabIndex.value == pageIndex
                                      ? ColorRes.textColorLight1
                                      : ColorRes.textColorLight3,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: CarouselSlider(
                      items: controller.tabImgs
                          .map(
                            (final item) => Padding(
                              padding: EdgeInsets.only(top: dim300h),
                              child: Align(
                                alignment: AlignmentDirectional.topCenter,
                                child: GetImage.getAssetsImage(
                                  item,
                                  width:
                                      MediaQuery.of(context).size.height * 0.17,
                                  height:
                                      MediaQuery.of(context).size.height * 0.17,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                        viewportFraction: 1,
                        disableCenter: true,
                        initialPage: controller.tabIndex.value,
                        onPageChanged: (final index, final reason) {
                          controller.tabIndex.value = index;
                        },
                      ),
                      carouselController: controller.carouselController,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: dim200h),
                  child: Obx(
                    () => controller.tabIndex.value == controller.initPageIndex
                        ? GestureDetector(
                            onTap: clickDebounce.clickDebounce(() {
                              controller.gotoFocusPage();
                            }),
                            child: WaterRipples(
                              radius: dim200w,
                              maxRadius: dim300w,
                              title: '专注',
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(dim200w, dim200h),
                              shape: const CircleBorder(),
                            ),
                            child: Icon(
                              Icons.lock,
                              size: dim80w,
                            ),
                          ),
                  ),
                ),
              ),
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
