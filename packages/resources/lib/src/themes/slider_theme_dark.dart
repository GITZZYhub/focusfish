import 'package:flutter/material.dart';
import '../../resources.dart';

class SliderThemeDark {
  SliderThemeDark._();
  static final SliderThemeData sliderTheme = SliderThemeData(
    activeTrackColor: ColorRes.primaryDark,
    inactiveTrackColor: ColorRes.primaryDark.withOpacity(0.6),
    disabledActiveTrackColor: ColorRes.onPrimaryDark.withOpacity(0.5),
    disabledInactiveTrackColor: ColorRes.onPrimaryDark.withOpacity(0.2),
    activeTickMarkColor: ColorRes.primaryVariantDark.withOpacity(0.8),
    inactiveTickMarkColor: ColorRes.primaryDark.withOpacity(0.8),
    disabledActiveTickMarkColor: ColorRes.primaryVariantDark.withOpacity(0.2),
    disabledInactiveTickMarkColor: ColorRes.onPrimaryDark.withOpacity(0.2),
    thumbColor: ColorRes.primaryDark,
    disabledThumbColor: ColorRes.onPrimaryDark.withOpacity(0.5),
    thumbShape: const RoundSliderThumbShape(),
    overlayColor: ColorRes.primaryDark.withOpacity(0.4),
    valueIndicatorColor: ColorRes.primaryDark,
    valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
    showValueIndicator: ShowValueIndicator.onlyForDiscrete,
    valueIndicatorTextStyle: TextStyle(
      color: ColorRes.textColorLight2,
      fontSize: bodyText2,
      fontWeight: WeightRes.regular,
      fontStyle: FontStyle.normal,
    ),
  );
}
