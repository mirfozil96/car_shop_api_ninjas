import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/style/app_theme.dart';

const String _spThemeKey = 'theme_mode';

class ThemeController with ChangeNotifier {
  ThemeController() : _themeMode = ThemeMode.system {
    SharedPreferences.getInstance().then<void>((sp) {
      final themeModeIndex = sp.getInt(_spThemeKey);
      if (themeModeIndex != null) {
        _themeMode = ThemeMode.values[themeModeIndex];
        notifyListeners();
      }
      log("Initialized ThemeController with theme mode: $_themeMode");
    });
  }

  ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;

  void switchThemeMode(ThemeMode newMode) {
    _themeMode = newMode;
    notifyListeners();
    SharedPreferences.getInstance().then<void>((sp) {
      sp.setInt(_spThemeKey, newMode.index);
    });
    log("Switched theme mode to: $_themeMode");
  }

  ThemeData get theme {
    switch (_themeMode) {
      case ThemeMode.light:
        return AppThemes.light();
      case ThemeMode.dark:
        return AppThemes.dark();
      case ThemeMode.system:
      default:
        return PlatformDispatcher.instance.platformBrightness == Brightness.dark
            ? AppThemes.dark()
            : AppThemes.light();
    }
  }
}
