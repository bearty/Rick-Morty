part of 'bloc.dart';

enum ThemeModeState { light, dark, bySettings, energySave }

class ThemeState extends Equatable {
  final ThemeMode themeMode;
  const ThemeState({
    this.themeMode,
  });

  ThemeState copyWith({
    ThemeMode themeMode,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object> get props => [themeMode];
}
