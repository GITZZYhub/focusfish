import 'package:common/constants/countries.dart';
import 'package:common/entity/city.dart';
import 'package:common/theme/theme_provider.dart';
import 'package:common/utils/init_util.dart';
import 'package:common/widgets/public_widget.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:getx/getx.dart';
import 'package:localization/localization.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:resources/resources.dart';

import 'custom_divider.dart';

class PhoneAreaCode extends StatefulWidget {
  const PhoneAreaCode({Key? key}) : super(key: key);

  @override
  _PhoneAreaCodeState createState() => _PhoneAreaCodeState();
}

class _PhoneAreaCodeState extends State<PhoneAreaCode>
    with
        // ignore: prefer_mixin
        WidgetsBindingObserver {
  // 原始数据，只做字符排序，不做修改
  List<City> cityOriginDataList = [];
  List<City> cityContentDataList = [];
  List<String> indexBarData = [];
  String? defaultLanguage;
  final textEditingController = TextEditingController();
  bool isShowClearIconButton = false;

  /// Controller to scroll or jump to a particular item.
  final itemScrollController = ItemScrollController();

  /// Listener that reports the position of items when the list is scrolled.
  final itemPositionsListener = ItemPositionsListener.create();

  // 侧边栏滑动监听
  IndexBarDragListener indexBarDragListener = IndexBarDragListener.create();

  // 侧边栏字母选择
  final IndexBarController indexBarController = IndexBarController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ThemeProvider.setExtraColor(context: context);
    });

    defaultLanguage = getCurrentServerLanguage(context);

    itemPositionsListener.itemPositions.addListener(_positionsChanged);

    indexBarDragListener.dragDetails.addListener(_valueChanged);

    _loadData();

    textEditingController.addListener(() {
      if (textEditingController.text.isEmpty) {
        isShowClearIconButton = false;
      } else {
        isShowClearIconButton = true;
      }
      setState(() {});
      _search(textEditingController.text);
    });
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    ThemeProvider.setExtraColor(context: Get.context!, needReverse: true);
    setState(() {});
  }

  ///列表header位置监听，更新侧边栏字母的位置
  void _positionsChanged() {
    final positions = itemPositionsListener.itemPositions.value;
    if (positions.isNotEmpty) {
      final itemPosition = positions
          .where((position) => position.itemTrailingEdge > 0)
          .reduce((min, position) =>
              position.itemTrailingEdge < min.itemTrailingEdge
                  ? position
                  : min);
      final index = itemPosition.index;
      indexBarController.updateTagIndex(indexBarData[index]);
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    indexBarDragListener.dragDetails.removeListener(_valueChanged);
    itemPositionsListener.itemPositions.removeListener(_positionsChanged);
    super.dispose();
  }

  Future<void> _loadData() async {
    cityOriginDataList.clear();
    final currentLanguage = getCurrentServerLanguage(context);
    cityOriginDataList.addAll(countries.map((param) {
      final model = City.fromJson(param);
      String tag;
      if (currentLanguage == ServerLanguage.zhCN) {
        model.value = model.zh;
        tag = PinyinHelper.getShortPinyin(model.value!)[0].toUpperCase();
      } else if (currentLanguage == ServerLanguage.zhTW) {
        model.value = model.tr;
        tag = PinyinHelper.getShortPinyin(model.value!)[0].toUpperCase();
      } else {
        model.value = model.en;
        tag = model.en.substring(0, 1).toUpperCase();
      }

      if (RegExp('[A-Z]').hasMatch(tag)) {
        model.tagIndex = tag;
      } else {
        model.tagIndex = '#';
      }
      return model;
    }).toList());

    //a~z排序
    sortListBySuspensionTag(cityOriginDataList);

    cityContentDataList
      ..clear()
      ..addAll(cityOriginDataList);

    //获取数据首字母列表集
    indexBarData.clear();
    final length = cityContentDataList.length;
    for (var i = 0; i < length; i++) {
      final city = cityContentDataList[i];
      final tagIndex = city.tagIndex;
      if (!indexBarData.contains(tagIndex)) {
        indexBarData.add(tagIndex!);
      }
    }
    //数据加载完成，页面刷新
    setState(() {});
  }

  ///搜索
  void _search(final String? searchedText) {
    if (searchedText == null || searchedText.isEmpty) {
      cityContentDataList
        ..clear()
        ..addAll(cityOriginDataList);
    } else {
      var compareValue = '';
      cityContentDataList
        ..clear()
        ..addAll(cityOriginDataList.where((value) {
          if (defaultLanguage == ServerLanguage.zhCN) {
            compareValue = value.zh;
            if (ChineseHelper.isChinese(searchedText)) {
              return compareValue.contains(searchedText);
            } else {
              final shortPinyinValue =
                  PinyinHelper.getShortPinyin(compareValue).toLowerCase();
              final fullPinyinValue = PinyinHelper.getPinyin(compareValue)
                  .toLowerCase()
                  .replaceAll(RegExp(r'\s+\b|\b\s'), ''); // 去掉空格
              final searchedTextPin =
                  PinyinHelper.getShortPinyin(searchedText).toLowerCase();
              return shortPinyinValue.contains(searchedTextPin) ||
                  fullPinyinValue.contains(searchedTextPin);
            }
          } else if (defaultLanguage == ServerLanguage.zhTW) {
            compareValue = value.tr;
            if (ChineseHelper.isTraditionalChinese(searchedText)) {
              return compareValue.contains(searchedText);
            } else {
              final shortPinyinValue =
                  PinyinHelper.getShortPinyin(compareValue).toLowerCase();
              final fullPinyinValue = PinyinHelper.getPinyin(compareValue)
                  .toLowerCase()
                  .replaceAll(RegExp(r'\s+\b|\b\s'), ''); // 去掉空格
              final searchedTextPin =
                  PinyinHelper.getShortPinyin(searchedText).toLowerCase();
              return shortPinyinValue.contains(searchedTextPin) ||
                  fullPinyinValue.contains(searchedTextPin);
            }
          } else {
            compareValue = value.en.toLowerCase();
            return compareValue.contains(searchedText.toLowerCase());
          }
        }).toList());
    }

    //获取数据首字母列表集
    indexBarData.clear();
    final length = cityContentDataList.length;
    for (var i = 0; i < length; i++) {
      final city = cityContentDataList[i];
      final tagIndex = city.tagIndex;
      if (!indexBarData.contains(tagIndex)) {
        indexBarData.add(tagIndex!);
      }
    }
  }

  /// 获取指定索引列表。
  List<City> getTagList(List<City>? cityDatas, String target) {
    final indexData = <City>[];
    if (cityDatas != null && cityDatas.isNotEmpty) {
      // ignore: prefer_final_locals
      for (var i = 0, length = cityDatas.length; i < length; i++) {
        final city = cityDatas[i];
        final tag = city.tagIndex;
        if (tag != null && tag == target) {
          indexData.add(city);
        }
      }
    }
    return indexData;
  }

  ///监听侧边栏选择并将列表滚动到指定位置
  void _valueChanged() {
    final details = indexBarDragListener.dragDetails.value;
    if (details.action == IndexBarDragDetails.actionDown ||
        details.action == IndexBarDragDetails.actionUpdate) {
      if (details.index != null) {
        itemScrollController.jumpTo(index: details.index!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentLanguage = getCurrentServerLanguage(context);
    if (defaultLanguage != currentLanguage) {
      defaultLanguage = currentLanguage;
      _loadData();
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            _getTitleWidget(context),
            Container(
              margin: EdgeInsets.symmetric(horizontal: dim18w),
              child: _getSearchTextField(),
            ),
            SizedBox(
              height: dim32h,
            ),
            Expanded(
              child: _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getTitleWidget(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          left: dim40w,
          top: dim40w,
          right: dim30w,
          bottom: dim40w,
        ),
        child: Row(
          children: [
            HeadLine6Text(text: AppLocalizations.of(context)!.choose_country),
            const Spacer(),
            IconButton(
              key: const Key('back'),
              padding: EdgeInsets.zero,
              onPressed: clickDebounce.clickDebounce(Get.back),
              icon: const Icon(
                Icons.close,
              ),
            ),
          ],
        ),
      );

  Widget _getSearchTextField() => TextField(
        textAlignVertical: TextAlignVertical.center,
        controller: textEditingController,
        minLines: 1,
        decoration: InputDecoration(
          fillColor: const Color(0x08000000),
          filled: true,
          hintText: AppLocalizations.of(context)!.search,
          contentPadding: EdgeInsets.zero,
          prefixIcon: Padding(
            padding: EdgeInsets.only(top: dim12h),
            child: const Icon(Icons.search),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(dim16w),
            borderSide: const BorderSide(
              color: Colors.transparent, //边线颜色为白色
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(dim16w),
            borderSide: const BorderSide(
              color: Colors.transparent, //边线颜色为白色
            ),
          ),
          suffixIcon: isShowClearIconButton
              ? IconButton(
                  onPressed: textEditingController.clear,
                  icon: const Icon(Icons.clear),
                )
              : null,
        ),
      );

  Widget _buildContent() => Stack(
        children: [
          GestureDetector(
            onPanDown: (_) {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: _buildListContent(),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IndexBar(
              data: indexBarData,
              indexBarDragListener: indexBarDragListener,
              controller: indexBarController,
              options: IndexBarOptions(
                needRebuild: true,
                selectTextStyle: TextStyle(
                    fontSize: overline,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
                selectItemDecoration:
                    // ignore: lines_longer_than_80_chars
                    BoxDecoration(
                        shape: BoxShape.circle,
                        color: ThemeProvider.indexBarBackgroundColor.value),
              ),
            ),
          ),
        ],
      );

  Widget _buildListContent() => ScrollablePositionedList.builder(
        itemCount: indexBarData.length,
        itemBuilder: (context, headIndex) => StickyHeader(
          header: Container(
            height: dim100h,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: dim56w),
            color: ThemeProvider.phoneAreaCodeTtitleBackgroundColor.value,
            alignment: Alignment.centerLeft,
            child: Text(
              indexBarData[headIndex],
              softWrap: false,
              style: TextStyle(
                fontSize: subtitle1,
                color: ThemeProvider.phoneAreaCodeTextColor.value,
              ),
            ),
          ),
          content: Container(
            color: ThemeProvider.themeBackgroundColor.value,
            child: _buildItemListView(headIndex),
          ),
        ),
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        physics: const BouncingScrollPhysics(),
      );

  Widget _buildItemListView(int headIndex) {
    final datas = getTagList(cityContentDataList, indexBarData[headIndex]);
    return ListView.separated(
      shrinkWrap: true,
      //为true可以解决子控件必须设置高度的问题
      physics: const NeverScrollableScrollPhysics(),
      //禁用滑动事件
      itemCount: datas.length,
      itemBuilder: (context, index) => _getSusItem(context, datas[index]),
      separatorBuilder: (context, index) {
        final itemsLength = datas.length;
        if (index < itemsLength - 1) {
          return Padding(
            padding: EdgeInsets.only(
              left: dim56w,
              right: dim100w,
            ),
            child: CustomDivider(
              color: ThemeProvider.dividerColor.value,
            ),
          );
        }
        return const Text('');
      },
    );
  }

  Widget _getSusItem(
    BuildContext context,
    City city,
  ) =>
      GestureDetector(
        onTap: () {
          Get.back(result: city);
        },
        child: Container(
          height: dim100h,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: dim56w),
          color: ThemeProvider.themeBackgroundColor.value,
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text(
                city.value!,
                softWrap: false,
                style: TextStyle(
                  fontSize: subtitle1,
                  color: ThemeProvider.phoneAreaCodeTextColor.value,
                ),
              ),
              const Spacer(),
              Text(
                '+${city.code}',
                softWrap: false,
                style: TextStyle(
                  fontSize: subtitle1,
                  color: ThemeProvider.phoneAreaCodeTextColor.value,
                ),
              ),
              SizedBox(
                width: dim100w,
              ),
            ],
          ),
        ),
      );

  /// sort list by suspension tag.
  /// 根据[A-Z]排序。
  void sortListBySuspensionTag(List<City>? list) {
    if (list == null || list.isEmpty) return;
    list.sort((a, b) {
      if (a.getSuspensionTag() == '@' || b.getSuspensionTag() == '#') {
        return -1;
      } else if (a.getSuspensionTag() == '#' || b.getSuspensionTag() == '@') {
        return 1;
      } else {
        return a.getSuspensionTag().compareTo(b.getSuspensionTag());
      }
    });
  }
}
