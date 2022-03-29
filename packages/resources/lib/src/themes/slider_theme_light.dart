import 'package:flutter/material.dart';
import '../../resources.dart';

class SliderThemeLight {
  SliderThemeLight._();
  static final SliderThemeData sliderTheme = SliderThemeData(
    activeTrackColor: ColorRes.primaryLight,
    inactiveTrackColor: ColorRes.primaryLight.withOpacity(0.6),
    disabledActiveTrackColor:
        ColorRes.appMaterialColorLight.shade700.withOpacity(0.5),
    disabledInactiveTrackColor:
        ColorRes.appMaterialColorLight.shade700.withOpacity(0.2),
    activeTickMarkColor:
        ColorRes.appMaterialColorLight.shade100.withOpacity(0.8),
    inactiveTickMarkColor: ColorRes.primaryLight.withOpacity(0.8),
    disabledActiveTickMarkColor:
        ColorRes.appMaterialColorLight.shade100.withOpacity(0.2),
    disabledInactiveTickMarkColor:
        ColorRes.appMaterialColorLight.shade700.withOpacity(0.2),
    thumbColor: ColorRes.primaryLight,
    disabledThumbColor:
        ColorRes.appMaterialColorLight.shade700.withOpacity(0.5),
    thumbShape: const RoundSliderThumbShape(),
    overlayColor: ColorRes.primaryLight.withOpacity(0.4),
    valueIndicatorColor: ColorRes.primaryLight,
    valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
    showValueIndicator: ShowValueIndicator.onlyForDiscrete,
    valueIndicatorTextStyle: TextStyle(
      color: ColorRes.textColorDark1,
      fontSize: bodyText2,
      fontWeight: WeightRes.regular,
      fontStyle: FontStyle.normal,
    ),
  );
}
