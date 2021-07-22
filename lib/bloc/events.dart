part of 'bloc.dart';

@immutable
abstract class ThemeEvent {}

/// Событие инициализации
class InitialThemeEvent extends ThemeEvent {}

/// Событие выбора темы
class SelectedThemeEvent extends ThemeEvent {
  final int themeId;
  SelectedThemeEvent(
    this.themeId,
  );
}

class TestThemeEvent extends ThemeEvent {}
