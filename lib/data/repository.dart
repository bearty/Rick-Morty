import 'package:flutter/material.dart';
import 'package:ricknmorty/theme/theme_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class Repository {
  Repository() {
    init();
  }

  Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SharedPreferences _prefs;

  ThemeMode getTheme() {
    final id = _prefs.getInt('theme');
    return ThemeNotifier().themeById(id);
  }
}
