import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

import '../constants/contants_value.dart';

AwesomeDialog getCoinsStatementDialog({
  required BuildContext context,
  required String restStartTime,
  required String restEndTime,
  required int restCount,
}) {
  return AwesomeDialog(
    context: context,
    headerAnimationLoop: false,
    dialogType: DialogType.NO_HEADER,
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '你得到了',
          style: TextStyle(fontSize: headline5),
        ),
        SizedBox(
          height: dim80h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetImage.getAssetsImage(
              R.png.coin,
              height: dim70h,
              width: dim70w,
            ),
            Text(
              Constants.coinPer.toString(),
              style: TextStyle(fontSize: headline5),
            ),
            Text(
              ' x $restCount',
            ),
          ],
        ),
        SizedBox(
          height: dim80h,
        ),
        Text(
          '"$restStartTime"~"$restEndTime"',
        ),
        Text(
          '专注&休息了$restCount次',
        ),
      ],
    ),
    btnOkOnPress: () {},
    btnOkText: '好',
    btnOkColor: Colors.blueAccent,
    dismissOnTouchOutside: false,
  );
}
