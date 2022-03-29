import 'package:flutter/material.dart';
import '../../resources.dart';

class InputDecorationThemeLight {
  InputDecorationThemeLight._();
  static final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    labelStyle: TextStyle(
      color: ColorRes.textColorLight3,
      fontSize: bodyText2,
      fontWeight: WeightRes.regular,
      fontStyle: FontStyle.normal,
    ),
    helperStyle: TextStyle(
      color: ColorRes.textColorLight3,
      fontSize: caption,
      fontWeight: WeightRes.regular,
      fontStyle: FontStyle.normal,
    ),
    hintStyle: TextStyle(
      color: ColorRes.textColorLight3,
      fontSize: bodyText2,
      fontWeight: WeightRes.regular,
      fontStyle: FontStyle.normal,
    ),
    errorStyle: TextStyle(
      color: ColorRes.errorColor,
      fontSize: caption,
      fontWeight: WeightRes.regular,
      fontStyle: FontStyle.normal,
    ),
    contentPadding: EdgeInsets.only(
      top: dim6h,
      left: dim12h,
      right: dim12h,
      bottom: dim6h,
    ),
    prefixStyle: TextStyle(
      color: ColorRes.textColorLight2,
      fontSize: bodyText2,
      fontWeight: WeightRes.regular,
      fontStyle: FontStyle.normal,
    ),
    suffixStyle: TextStyle(
      color: ColorRes.textColorLight2,
      fontSize: bodyText2,
      fontWeight: WeightRes.regular,
      fontStyle: FontStyle.normal,
    ),
    counterStyle: TextStyle(
      color: ColorRes.textColorLight3,
      fontSize: caption,
      fontWeight: WeightRes.regular,
      fontStyle: FontStyle.normal,
    ),
    fillColor: Colors.transparent,
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: ColorRes.errorColor,
        width: dim2w,
      ),
      borderRadius: BorderRadius.all(Radius.circular(dim4w)),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: ColorRes.secondaryVariantLight,
        width: dim6w,
      ),
      borderRadius: BorderRadius.all(Radius.circular(dim4w)),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: ColorRes.errorColorVariant,
        width: dim6w,
      ),
      borderRadius: BorderRadius.all(Radius.circular(dim4w)),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: ColorRes.disabledColorLight,
        width: dim2w,
      ),
      borderRadius: BorderRadius.all(Radius.circular(dim4w)),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: ColorRes.secondaryLight,
        width: dim2w,
      ),
      borderRadius: BorderRadius.all(Radius.circular(dim4w)),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(
        color: ColorRes.secondaryLight,
        width: dim2w,
      ),
      borderRadius: BorderRadius.all(Radius.circular(dim4w)),
    ),
  );
}
