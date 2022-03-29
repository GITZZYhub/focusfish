library rich_text_widget;

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

// RichTextWidget
class RichTextWidget extends StatelessWidget {
  final Text defaultText;
  final List<BaseRichText> richTexts;
  final List<TextSpan> _resultRichTexts = [];
  final int? maxLines;
  final bool caseSensitive; //Whether to ignore case
  RichTextWidget(
    this.defaultText, {
    final this.richTexts = const [],
    final this.caseSensitive = true,
    final this.maxLines,
  }) {
    separateText();
  }
  //Split string
  void separateText() {
    final result = <_RichTextModel>[];
    final defaultStr = defaultText.data ?? '';
    //Find the position of the substring
    richTexts.asMap().forEach((final _, final richText) {
      final regex = RegExp(richText.data, caseSensitive: caseSensitive);
      regex.allMatches(defaultStr).forEach((final match) {
        final start = match.start;
        final end = match.end;
        if (end > start) {
          result
              .add(_RichTextModel(start: start, end: end, richText: richText));
        }
      });
    });
    if (result.isEmpty) {
      _resultRichTexts
          .add(TextSpan(text: defaultText.data, style: defaultText.style));
      return;
    }
    //Sort by start
    result.sort((final a, final b) => a.start - b.start);

    var start = 0;
    var i = 0;
    // Add the corresponding TextSpan
    while (i < result.length) {
      final model = result[i];
      if (model.start > start) {
        final defaultSubStr = defaultStr.substring(start, model.start);
        _resultRichTexts
            .add(TextSpan(text: defaultSubStr, style: defaultText.style));
      }

      final richSubStr = defaultStr.substring(
        model.start >= start ? model.start : start,
        model.end,
      );
      _resultRichTexts.add(
        TextSpan(
          text: richSubStr,
          style: model.richText.style,
          recognizer: model.richText.onTap != null
              ? (TapGestureRecognizer()..onTap = model.richText.onTap)
              : null,
        ),
      );
      start = model.end;
      i++;
      if (i == result.length && start < defaultStr.length) {
        final defaultSubStr = defaultStr.substring(start, defaultStr.length);
        _resultRichTexts
            .add(TextSpan(text: defaultSubStr, style: defaultText.style));
      }
    }
  }

  @override
  Widget build(final BuildContext context) => RichText(
        maxLines: maxLines,
        text: TextSpan(children: _resultRichTexts),
      );
}

// BaseRichText
class BaseRichText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final GestureTapCallback? onTap;
  const BaseRichText(this.data, {final this.style, final this.onTap});
  @override
  Widget build(final BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Text(
          data,
          style: style,
        ),
      );
}

// RichTextModel
class _RichTextModel {
  final int start;
  final int end;
  final BaseRichText richText;
  _RichTextModel({
    required final this.start,
    required final this.end,
    required final this.richText,
  });
}
