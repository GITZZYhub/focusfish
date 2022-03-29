# localization

国际化更新操作步骤
第一步：在./lib/l10n/tools/1measure_app_translation.csv文件中按照格式添加国际化文本
第二步：删除all_languages.dart并执行update_localizations.dart文件，命令窗口中打印Done...即为执行成功
第三步：打开./pubspec.yaml文件，运行Pub get 命令
第四步：将自动生成的./.dart_tool/flutter_gen/gen_l10/文件目录下的文件拷贝到./lib/src/目录下即可
到此国际化文件更新成功