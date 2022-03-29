import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

ThemeData lightThemeData = themeDataLight();
ThemeData darkThemeData = themeDataDark();

enum themeSettings {
  system,
  light,
  dark,
}

ThemeData themeDataLight() => ThemeData(
      // 定义一个单一的颜色以及十个色度的色块。
      primarySwatch: ColorRes.appMaterialColorLight,
      // 应用整体主题的亮度。用于按钮之类的小部件，以确定在不使用主色或强调色时选择什么颜色。
      brightness: Brightness.light,
      // 应用程序主要部分的背景颜色(toolbars、tab bars 等)
      primaryColor: ColorRes.primaryLight,
      // primaryColor的亮度。用于确定文本的颜色和放置在主颜色之上的图标(例如工具栏文本)。
      primaryColorBrightness: Brightness.dark,
      // primaryColor的浅色版
      primaryColorLight: ColorRes.appMaterialColorLight.shade100,
      // primaryColor的深色版
      primaryColorDark: ColorRes.appMaterialColorLight.shade700,
      colorScheme: ColorSchemeLight.colorScheme,
      //  MaterialType.canvas 的默认颜色
      canvasColor: ColorRes.backgroundLight,
      // Scaffold的默认颜色。典型Material应用程序或应用程序内页面的背景颜色。
      scaffoldBackgroundColor: ColorRes.backgroundLight,
      // Card的颜色
      cardColor: ColorRes.surfaceLight,
      // Divider和PopupMenuDivider的颜色，也用于ListTile之间、DataTable的行之间等
      dividerColor: ColorRes.dividerColorLight,
      // 选中在泼墨动画期间使用的突出显示颜色，或用于指示菜单中的项。
      highlightColor: ColorRes.highlightColorLight,
      // 墨水飞溅的颜色。InkWell
      splashColor: ColorRes.splashColorLight,
      // 用于突出显示选定行的颜色。
      selectedRowColor: ColorRes.selectedRowColor,
      // 用于处于非活动(但已启用)状态的小部件的颜色。例如，未选中的复选框。通常与accentColor形成对比。也看到disabledColor。
      unselectedWidgetColor: ColorRes.appMaterialColorLight.shade200,
      // 禁用状态下部件的颜色，无论其当前状态如何。例如，一个禁用的复选框(可以选中或未选中)。
      disabledColor: ColorRes.disabledColorLight,
      // 用于突出显示Switch、Radio和Checkbox等可切换小部件的活动状态的颜色。
      toggleableActiveColor: ColorRes.appMaterialColorLight.shade600,
      // 选定行时PaginatedDataTable标题的颜色。
      secondaryHeaderColor: ColorRes.appMaterialColorLight.shade50,
      textSelectionTheme: TextFieldThemeLight.textSelectionTheme,
      // 与主色形成对比的颜色，例如用作进度条的剩余部分。
      backgroundColor: ColorRes.appMaterialColorLight.shade200,
      // Dialog 元素的背景颜色
      dialogBackgroundColor: ColorRes.surfaceLight,
      // 选项卡中选定的选项卡指示器的颜色。
      indicatorColor: ColorRes.appMaterialColorLight.shade300,
      // 用于提示文本或占位符文本的颜色，例如在TextField中。
      hintColor: ColorRes.hintColorLight,
      // 用于输入验证错误的颜色，例如在TextField中
      errorColor: ColorRes.errorColor,
      elevatedButtonTheme:
          ElevatedButtonThemeData(style: ElevatedButtonStyleLight.buttonStyle),
      outlinedButtonTheme:
          OutlinedButtonThemeData(style: OutlineButtonStyleLight.buttonStyle),
      textButtonTheme:
          TextButtonThemeData(style: TextButtonStyleLight.buttonStyle),
      // 文本的颜色与卡片和画布的颜色形成对比。
      textTheme: TextThemeLight.textTheme,
      // 与primaryColor形成对比的文本主题
      primaryTextTheme: TextThemeLight.primaryTextTheme,
      // 基于这个主题的 InputDecorator、TextField和TextFormField的默认InputDecoration值。
      inputDecorationTheme: InputDecorationThemeLight.inputDecorationTheme,
      // 与卡片和画布颜色形成对比的图标主题
      iconTheme: IconThemeLight.iconTheme,
      // 与primaryColor形成对比的图标主题
      primaryIconTheme: IconThemeLight.primaryIconTheme,
      // 用于呈现Slider的颜色和形状
      sliderTheme: SliderThemeLight.sliderTheme,
      // 用于自定义选项卡栏指示器的大小、形状和颜色的主题。
      tabBarTheme: TabBarThemeData.tabBarTheme,
      // 自定义Dialog的主题形状
      dialogTheme: DialogThemeLight.dialogTheme,
      appBarTheme: AppBarThemeDataLight.appBarTheme,
      bottomAppBarTheme: BottomAppBarThemeDataLight.bottomAppBarTheme,
      bottomNavigationBarTheme: BottomNavThemeDataLight.bottomNavTheme,
      // 自定义snackBar的主题
      snackBarTheme: SnackBarTheme.snackBarTheme,
      checkboxTheme: CheckboxThemeLight.checkboxTheme,
      fontFamily: fontFamily,
    );

ThemeData themeDataDark() => ThemeData(
      // 定义一个单一的颜色以及十个色度的色块。
      primarySwatch: ColorRes.appMaterialColorDark,
      // 应用整体主题的亮度。用于按钮之类的小部件，以确定在不使用主色或强调色时选择什么颜色。
      brightness: Brightness.dark,
      // 应用程序主要部分的背景颜色(toolbars、tab bars 等)
      primaryColor: ColorRes.primaryDark,
      // primaryColor的亮度。用于确定文本的颜色和放置在主颜色之上的图标(例如工具栏文本)。
      primaryColorBrightness: Brightness.dark,
      // primaryColor的浅色版
      primaryColorLight: ColorRes.primaryVariantDark,
      // primaryColor的深色版
      primaryColorDark: Colors.black,
      colorScheme: ColorSchemeDark.colorScheme,
      //  MaterialType.canvas 的默认颜色
      canvasColor: ColorRes.backgroundDark,
      // Scaffold的默认颜色。典型Material应用程序或应用程序内页面的背景颜色。
      scaffoldBackgroundColor: ColorRes.backgroundDark,
      // Card的颜色
      cardColor: ColorRes.surfaceDark,
      // Divider和PopupMenuDivider的颜色，也用于ListTile之间、DataTable的行之间等
      dividerColor: ColorRes.dividerColorDark,
      // 选中在泼墨动画期间使用的突出显示颜色，或用于指示菜单中的项。
      highlightColor: ColorRes.highlightColorDark,
      // 墨水飞溅的颜色。InkWell
      splashColor: ColorRes.splashColorDark,
      // 用于突出显示选定行的颜色。
      selectedRowColor: ColorRes.selectedRowColor,
      // 用于处于非活动(但已启用)状态的小部件的颜色。例如，未选中的复选框。通常与accentColor形成对比。也看到disabledColor。
      unselectedWidgetColor: ColorRes.appMaterialColorDark.shade200,
      // 禁用状态下部件的颜色，无论其当前状态如何。例如，一个禁用的复选框(可以选中或未选中)。
      disabledColor: ColorRes.disabledColorDark,
      // 用于突出显示Switch、Radio和Checkbox等可切换小部件的活动状态的颜色。
      toggleableActiveColor: ColorRes.secondaryDark,
      // 选定行时PaginatedDataTable标题的颜色。
      secondaryHeaderColor: ColorRes.secondaryHeaderColorDark,
      textSelectionTheme: TextFieldThemeDark.textSelectionTheme,
      // 与主色形成对比的颜色，例如用作进度条的剩余部分。
      backgroundColor: ColorRes.secondaryHeaderColorDark,
      // Dialog 元素的背景颜色
      dialogBackgroundColor: ColorRes.surfaceDark,
      // 选项卡中选定的选项卡指示器的颜色。
      indicatorColor: ColorRes.secondaryDark,
      // 用于提示文本或占位符文本的颜色，例如在TextField中。
      hintColor: ColorRes.hintColorDark,
      // 用于输入验证错误的颜色，例如在TextField中
      errorColor: ColorRes.errorColor,
      elevatedButtonTheme:
          ElevatedButtonThemeData(style: ElevatedButtonStyleDark.buttonStyle),
      outlinedButtonTheme:
          OutlinedButtonThemeData(style: OutlineButtonStyleDark.buttonStyle),
      textButtonTheme:
          TextButtonThemeData(style: TextButtonStyleDark.buttonStyle),
      // 文本的颜色与卡片和画布的颜色形成对比。
      textTheme: TextThemeDark.textTheme,
      // 与primaryColor形成对比的文本主题
      primaryTextTheme: TextThemeDark.primaryTextTheme,
      // 基于这个主题的 InputDecorator、TextField和TextFormField的默认InputDecoration值。
      inputDecorationTheme: InputDecorationThemeDark.inputDecorationTheme,
      // 与卡片和画布颜色形成对比的图标主题
      iconTheme: IconThemeDark.iconTheme,
      // 与primaryColor形成对比的图标主题
      primaryIconTheme: IconThemeDark.primaryIconTheme,
      // 用于呈现Slider的颜色和形状
      sliderTheme: SliderThemeDark.sliderTheme,
      // 用于自定义选项卡栏指示器的大小、形状和颜色的主题。
      tabBarTheme: TabBarThemeData.tabBarTheme,
      // 自定义Dialog的主题形状
      dialogTheme: DialogThemeDark.dialogTheme,
      appBarTheme: AppBarThemeDataDark.appBarTheme,
      bottomAppBarTheme: BottomAppBarThemeDataDark.bottomAppBarTheme,
      bottomNavigationBarTheme: BottomNavThemeDataDark.bottomNavTheme,
      // 自定义snackBar的主题
      snackBarTheme: SnackBarTheme.snackBarTheme,
      checkboxTheme: CheckboxThemeDark.checkboxTheme,
      fontFamily: fontFamily,
    );
