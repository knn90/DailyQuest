import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'daily_quest/data/model/local_daily_quest.dart';
import 'daily_quest/data/model/local_task.dart';
import 'daily_quest/presentation/quest_list.dart';

const dailyQuestBox = 'DailyQuest';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(LocalDailyQuestAdapter());
  Hive.registerAdapter(LocalTaskAdapter());
  await Hive.openBox(dailyQuestBox);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Quest',
      theme: FlexThemeData.light(
        colors: const FlexSchemeColor(
          primary: Color(0xff00296b),
          primaryContainer: Color(0xffa0c2ed),
          secondary: Color(0xff808594),
          secondaryContainer: Color(0xffffd270),
          tertiary: Color(0xff5c5c95),
          tertiaryContainer: Color(0xffc8dbf8),
          appBarColor: Color(0xffc8dcf8),
          error: null,
        ),
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 10,
        appBarStyle: FlexAppBarStyle.background,
        bottomAppBarElevation: 1.0,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
          blendTextTheme: true,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
          thickBorderWidth: 2.0,
          elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
          elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
          outlinedButtonOutlineSchemeColor: SchemeColor.primary,
          toggleButtonsBorderSchemeColor: SchemeColor.primary,
          segmentedButtonSchemeColor: SchemeColor.primary,
          segmentedButtonBorderSchemeColor: SchemeColor.primary,
          unselectedToggleIsColored: true,
          sliderValueTinted: true,
          inputDecoratorSchemeColor: SchemeColor.primary,
          inputDecoratorBackgroundAlpha: 15,
          inputDecoratorRadius: 10.0,
          inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
          chipRadius: 10.0,
          popupMenuRadius: 6.0,
          popupMenuElevation: 6.0,
          appBarScrolledUnderElevation: 8.0,
          drawerWidth: 280.0,
          drawerIndicatorSchemeColor: SchemeColor.primary,
          bottomNavigationBarMutedUnselectedLabel: false,
          bottomNavigationBarMutedUnselectedIcon: false,
          menuRadius: 6.0,
          menuElevation: 6.0,
          menuBarRadius: 0.0,
          menuBarElevation: 1.0,
          navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
          navigationBarMutedUnselectedLabel: false,
          navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
          navigationBarMutedUnselectedIcon: false,
          navigationBarIndicatorSchemeColor: SchemeColor.primary,
          navigationBarIndicatorOpacity: 1.00,
          navigationBarElevation: 2.0,
          navigationBarHeight: 70.0,
          navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
          navigationRailMutedUnselectedLabel: false,
          navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
          navigationRailMutedUnselectedIcon: false,
          navigationRailIndicatorSchemeColor: SchemeColor.primary,
          navigationRailIndicatorOpacity: 1.00,
        ),
        keyColors: const FlexKeyColors(
          useTertiary: true,
          keepPrimary: true,
          keepTertiary: true,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,

        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      darkTheme: FlexThemeData.dark(
        colors: const FlexSchemeColor(
          primary: Color(0xffb1cff5),
          primaryContainer: Color(0xff3873ba),
          secondary: Color(0xff808594),
          secondaryContainer: Color(0xffd26900),
          tertiary: Color(0xffc9cbfc),
          tertiaryContainer: Color(0xff535393),
          appBarColor: Color(0xff00102b),
          error: null,
        ),
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 15,
        appBarStyle: FlexAppBarStyle.background,
        bottomAppBarElevation: 2.0,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 40,
          blendTextTheme: true,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
          thickBorderWidth: 2.0,
          elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
          elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
          outlinedButtonOutlineSchemeColor: SchemeColor.primary,
          toggleButtonsBorderSchemeColor: SchemeColor.primary,
          segmentedButtonSchemeColor: SchemeColor.primary,
          segmentedButtonBorderSchemeColor: SchemeColor.primary,
          unselectedToggleIsColored: true,
          sliderValueTinted: true,
          inputDecoratorSchemeColor: SchemeColor.primary,
          inputDecoratorBackgroundAlpha: 22,
          inputDecoratorRadius: 10.0,
          chipRadius: 10.0,
          popupMenuRadius: 6.0,
          popupMenuElevation: 6.0,
          drawerWidth: 280.0,
          drawerIndicatorSchemeColor: SchemeColor.primary,
          bottomNavigationBarMutedUnselectedLabel: false,
          bottomNavigationBarMutedUnselectedIcon: false,
          menuRadius: 6.0,
          menuElevation: 6.0,
          menuBarRadius: 0.0,
          menuBarElevation: 1.0,
          navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
          navigationBarMutedUnselectedLabel: false,
          navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
          navigationBarMutedUnselectedIcon: false,
          navigationBarIndicatorSchemeColor: SchemeColor.primary,
          navigationBarIndicatorOpacity: 1.00,
          navigationBarElevation: 2.0,
          navigationBarHeight: 70.0,
          navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
          navigationRailMutedUnselectedLabel: false,
          navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
          navigationRailMutedUnselectedIcon: false,
          navigationRailIndicatorSchemeColor: SchemeColor.primary,
          navigationRailIndicatorOpacity: 1.00,
        ),
        keyColors: const FlexKeyColors(
          useTertiary: true,
          keepPrimary: true,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
      ),
      home: const DailyQuestList(),
    );
  }
}
