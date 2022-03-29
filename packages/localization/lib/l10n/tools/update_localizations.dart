import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';

void main() {
  updateLocalizationFile();
}

Future<void> updateLocalizationFile() async {
  var _phraseKey = '';
  final _localizations = <LocalizationModel>[];

  try {
    const root = 'lib/l10n';
    const filePath = '$root/tools/app_translation.csv';
    stdout
      ..writeln()
      ..writeln('---------------------------------------')
      ..writeln('Read file "$filePath"...')
      ..writeln('---------------------------------------');
    final input = File(filePath).openRead();

    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter(
          shouldParseNumbers: false,
        ))
        .toList();

    final index = fields[0]
        .cast<String>()
        .map(_uniformizeKey)
        .takeWhile((final x) => x.isNotEmpty)
        .toList();

    for (var r = 1; r < fields.length; r++) {
      final rowValues = fields[r];

      /// Creating a map
      final row = Map<String, String>.fromEntries(
        rowValues
            .asMap()
            .entries
            .where(
              (final e) => e.key < index.length,
            )
            .map(
              (final e) => MapEntry(index[e.key], e.value),
            ),
      );
      print('row: $row');

      row.forEach((final key, final value) {
        if (key == 'Key') {
          _phraseKey = value;
        } else {
          var _languageAdded = false;
          for (final element in _localizations) {
            if (element.language == key) {
              element.phrases.add(PhraseModel(key: _phraseKey, phrase: value));
              _languageAdded = true;
            }
          }

          if (_languageAdded == false) {
            _localizations.add(LocalizationModel(
                language: key,
                phrases: [PhraseModel(key: _phraseKey, phrase: value)]));
          }
        }
      });
    }

    for (final _localization in _localizations) {
      final _language = _localization.language;
      final file = File('$root/intl_$_language.arb');
      var _currentLanguageTextCode = '{\n';
      final l = _localization.phrases.length;
      _localization.phrases.asMap().forEach((final index, final _phrase) {
        final _phraseKey = _phrase.key;
        final _phrasePhrase = _phrase.phrase.replaceAll(r"'", "\\\'");
        String _currentPhraseTextCode;
        if (index == l - 1) {
          _currentPhraseTextCode = '    "$_phraseKey": "$_phrasePhrase"\n';
        } else {
          _currentPhraseTextCode = '    "$_phraseKey": "$_phrasePhrase",\n';
        }
        _currentLanguageTextCode += _currentPhraseTextCode;
      });
      const _currentLanguageCodeEnding = '}';
      _currentLanguageTextCode += _currentLanguageCodeEnding;
      await file.writeAsString(_currentLanguageTextCode);
      if (_language.contains('CN')) {
        await file.copy('$root/intl_zh.arb');
        await file.copy('$root/intl_zh_Hans.arb');
        await file.copy('$root/intl_zh_Hans_CN.arb');
        await file.copy('$root/intl_zh_Hans_HK.arb');
        await file.copy('$root/intl_zh_Hans_MO.arb');
        await file.copy('$root/intl_zh_Hans_SG.arb');
        await file.copy('$root/intl_zh_SG.arb');
      } else if (_language.contains('TW')) {
        await file.copy('$root/intl_zh_HK.arb');
        await file.copy('$root/intl_zh_Hant.arb');
        await file.copy('$root/intl_zh_Hant_CN.arb');
        await file.copy('$root/intl_zh_Hant_HK.arb');
        await file.copy('$root/intl_zh_Hant_MO.arb');
        await file.copy('$root/intl_zh_Hant_TW.arb');
        await file.copy('$root/intl_zh_MO.arb');
      }
    }

    const allLanguages = '''
class AllLanguages {
  static const zh_Hant_HK = 'zh_Hant_HK';
  static const zh_MO = 'zh_MO';
  static const zh_Hans_MO = 'zh_Hans_MO';
  static const zh_Hans = 'zh_Hans';
  static const zh_Hant = 'zh_Hant';
  static const zh_Hant_TW = 'zh_Hant_TW';
  static const zh_Hant_MO = 'zh_Hant_MO';
  static const zh_SG = 'zh_SG';
  static const zh_Hans_CN = 'zh_Hans_CN';
  static const zh_HK = 'zh_HK';
  static const zh = 'zh';
  static const zh_TW = 'zh_TW';
  static const ja = 'ja';
  static const en = 'en';
  static const zh_Hans_HK = 'zh_Hans_HK';
  static const zh_CN = 'zh_CN';
  static const zh_Hans_SG = 'zh_Hans_SG';
  static const zh_Hant_CN = 'zh_Hant_CN';
  
  static List<String> listEN = [en];
  static List<String> listJA = [ja];
  //繁体
  static List<String> listTR = [zh_Hant_HK, zh_MO, zh_Hant, zh_Hant_TW, zh_Hant_MO, zh_SG, zh_HK, zh_TW, zh_Hant_CN];
  //简体
  static List<String> listCN = [zh_Hans_MO, zh_Hans, zh_Hans_CN, zh, zh_Hans_HK, zh_CN, zh_Hans_SG];
}
    ''';
    final file = File('$root/tools/all_languages.dart');
    await file.writeAsString(allLanguages);

    stdout..writeln()..writeln('Done...');
  } on Exception catch (e) {
    //output error
    stderr.writeln(e.toString());
  }
}

String _uniformizeKey(final String key) {
  final newKey = key.trim().replaceAll('\n', '');
  return newKey;
}

//Localization Model
class LocalizationModel {
  final String language;
  final List<PhraseModel> phrases;

  LocalizationModel({
    required this.language,
    required this.phrases,
  });

  factory LocalizationModel.fromMap(final Map<dynamic, dynamic> data) =>
      LocalizationModel(
        language: data['language'],
        phrases: (data['phrases'] as List)
            .map((final v) => PhraseModel.fromMap(v))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'language': language,
        'phrases': List<dynamic>.from(phrases.map((final x) => x.toJson())),
      };
}

class PhraseModel {
  String key;
  String phrase;

  PhraseModel({required this.key, required this.phrase});

  factory PhraseModel.fromMap(final Map<dynamic, dynamic> data) => PhraseModel(
        key: data['key'],
        phrase: data['phrase'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'key': key,
        'phrase': phrase,
      };
}
