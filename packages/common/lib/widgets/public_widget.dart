import 'package:common/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:getx/getx.dart';
import 'package:resources/resources.dart';

import 'custom_divider.dart';

class NextIcon extends StatelessWidget {
  const NextIcon({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => const Icon(
        CupertinoIcons.forward,
        color: ColorRes.iconForwardColor,
      );
}

class PreferenceErrorText extends StatelessWidget {
  const PreferenceErrorText({
    final Key? key,
    required final this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(final BuildContext context) => Wrap(
        children: [
          Text(
            text,
            style: TextStyle(fontSize: caption, color: ColorRes.errorColor),
          )
        ],
      );
}

class HeadLine1Text extends StatelessWidget {
  const HeadLine1Text({
    final Key? key,
    required final this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(final BuildContext context) => Text(
        text,
        style: Theme.of(context).textTheme.headline1,
      );
}

class HeadLine2Text extends StatelessWidget {
  const HeadLine2Text({
    final Key? key,
    required final this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(final BuildContext context) => Text(
        text,
        style: Theme.of(context).textTheme.headline2,
      );
}

class HeadLine3Text extends StatelessWidget {
  const HeadLine3Text({
    final Key? key,
    required final this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(final BuildContext context) => Text(
        text,
        style: Theme.of(context).textTheme.headline3,
      );
}

class HeadLine4Text extends StatelessWidget {
  const HeadLine4Text({
    final Key? key,
    required final this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(final BuildContext context) => Text(
        text,
        style: Theme.of(context).textTheme.headline4,
      );
}

class HeadLine5Text extends StatelessWidget {
  const HeadLine5Text({
    final Key? key,
    required final this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(final BuildContext context) => Text(
        text,
        style: Theme.of(context).textTheme.headline5,
      );
}

class HeadLine6Text extends StatelessWidget {
  const HeadLine6Text({
    final Key? key,
    required final this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(final BuildContext context) => Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      );
}

class Subtitle1Text extends StatelessWidget {
  const Subtitle1Text({
    final Key? key,
    required final this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(final BuildContext context) => Text(
        text,
        style: Theme.of(context).textTheme.subtitle1,
      );
}

class Subtitle2Text extends StatelessWidget {
  const Subtitle2Text({
    final Key? key,
    required final this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(final BuildContext context) => Text(
        text,
        style: Theme.of(context).textTheme.subtitle2,
      );
}

class BodyText1Text extends StatelessWidget {
  const BodyText1Text({
    final Key? key,
    required final this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(final BuildContext context) => Text(
        text,
        style: Theme.of(context).textTheme.bodyText1,
      );
}

class BodyText2Text extends StatelessWidget {
  const BodyText2Text({
    final Key? key,
    required final this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(final BuildContext context) => Text(
        text,
        style: Theme.of(context).textTheme.bodyText2,
      );
}

class CaptionText extends StatelessWidget {
  const CaptionText({
    final Key? key,
    required final this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(final BuildContext context) => Text(
        text,
        style: Theme.of(context).textTheme.caption,
      );
}

class ButtonText extends StatelessWidget {
  const ButtonText({
    final Key? key,
    required final this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(final BuildContext context) => Text(
        text,
        style: Theme.of(context).textTheme.button,
      );
}

class OverlineText extends StatelessWidget {
  const OverlineText({
    final Key? key,
    required final this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(final BuildContext context) => Text(
        text,
        style: Theme.of(context).textTheme.overline,
      );
}

class LineDivider extends StatelessWidget {
  const LineDivider({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => CustomDivider(
        height: dim1h,
        color: ColorRes.itemDividerColor,
      );
}

class RichTextWrapper extends StatefulWidget {
  const RichTextWrapper({
    final Key? key,
    required final this.text,
    required final this.subText,
    final this.clickType,
    final this.clickListener,
  }) : super(key: key);
  final String text;
  final String subText;
  final int? clickType;
  final RichTextClickListener? clickListener;

  @override
  RichTextWrapperState createState() => RichTextWrapperState();
}

class RichTextWrapperState extends State<RichTextWrapper>
    with
        // ignore: prefer_mixin
        WidgetsBindingObserver {
  late String _text;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((final timeStamp) {
      ThemeProvider.setExtraColor(context: Get.context!);
    });
    _text = widget.text;
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    ThemeProvider.setExtraColor(context: Get.context!, needReverse: true);
    setState(() {});
  }

  @override
  Widget build(final BuildContext context) {
    _text = _text.replaceAll('%s', widget.subText);
    if (_text.contains(widget.subText)) {
      final strs = _text.split(widget.subText);
      return RichText(
        text: TextSpan(
          text: strs[0],
          style: TextStyle(
            color: ThemeProvider.phoneAreaCodeTextColor.value,
          ),
          children: <TextSpan>[
            TextSpan(
              text: widget.subText,
              style: const TextStyle(
                color: ColorRes.textButtonColor,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w500,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  widget.clickListener!.call();
                },
            ),
            TextSpan(
              text: strs[1],
              style: TextStyle(
                color: ThemeProvider.phoneAreaCodeTextColor.value,
              ),
            ),
          ],
        ),
      );
    } else {
      return RichText(
        text: TextSpan(
          text: _text,
          style: TextStyle(
            color: ThemeProvider.phoneAreaCodeTextColor.value,
          ),
        ),
      );
    }
  }
}

typedef RichTextClickListener = void Function();

class KeepAliveWrapper extends StatefulWidget {
  const KeepAliveWrapper({
    Key? key,
    this.keepAlive = true,
    required this.child,
  }) : super(key: key);
  final bool keepAlive;
  final Widget child;

  @override
  _KeepAliveWrapperState createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  void didUpdateWidget(covariant KeepAliveWrapper oldWidget) {
    if(oldWidget.keepAlive != widget.keepAlive) {
      // keepAlive 状态需要更新，实现在 AutomaticKeepAliveClientMixin 中
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}
