import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equatable/equatable.dart';

part 'events.dart';
part 'state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeMode: ThemeMode.dark));
  var themeId = 1;

  /// Отслеживает события
  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is InitialThemeEvent) {
      yield* _buildInitialThemeEvent(state);
    }
    if (event is SelectedThemeEvent) {
      yield* _buildSelectedThemeEvent(event);
    }
    if (event is TestThemeEvent) {
      yield* _testThemeEvent(event);
    }
  }

  Stream<ThemeState> _testThemeEvent(TestThemeEvent event) async* {
    print('_testThemeEvent');
    print(state);
  }

  Stream<ThemeState> _buildInitialThemeEvent(ThemeState state) async* {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    themeId = _prefs.getInt('theme');
    if (themeId != null) {
      ThemeMode themeMode = getTheme(themeId);

      /// Возвращаем состояние
      yield ThemeState(themeMode: themeMode);
    }
  }

  Stream<ThemeState> _buildSelectedThemeEvent(SelectedThemeEvent event) async* {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setInt('theme', event.themeId);
    yield ThemeState(themeMode: getTheme(event.themeId));
  }

  ThemeMode getTheme(int themeId) {
    print("themeId : $themeId");
    switch (themeId) {
      case 0:
        return ThemeMode.light;
      case 1:
        return ThemeMode.dark;
      case 2:
        return ThemeMode.system;
      default:
        return ThemeMode.dark;
    }
  }
}
