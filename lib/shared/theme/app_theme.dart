import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_exporter/shared/theme/app_colors.dart';
import 'package:google_exporter/shared/theme/text_styles.dart';
import 'package:google_exporter/shared/theme/text_theme.dart';

final appThemeProvider = StateNotifierProvider<AppThemeModeNotifier, ThemeMode>(
  (ref) {
    return AppThemeModeNotifier();
  },
);

class AppThemeModeNotifier extends StateNotifier<ThemeMode> {
  AppThemeModeNotifier() : super(ThemeMode.light) {
    getCurrentTheme();
  }
  ThemeMode currentTheme = ThemeMode.light;

  void toggleTheme() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }

  Future<void> getCurrentTheme() async {
    final value = ThemeMode.values.byName(currentTheme.name);
    state = value;
  }
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: AppTextStyles.fontFamily,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.lightGrey,
        error: AppColors.error,
        background: AppColors.black,
      ),
      // backgroundColor: AppColors.black,
      scaffoldBackgroundColor: AppColors.black,
      textTheme: TextThemes.darkTextTheme,
      primaryTextTheme: TextThemes.primaryTextTheme,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.black,
        titleTextStyle: AppTextStyles.h2,
      ),
    );
  }

  /// Light theme data of the app
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      textTheme: TextThemes.textTheme,
      primaryTextTheme: TextThemes.primaryTextTheme,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.lightGrey,
        error: AppColors.error,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
