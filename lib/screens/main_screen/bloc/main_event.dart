part of 'main_bloc.dart';

abstract class MainScreenEvent {
  const MainScreenEvent();
}

class InitialMainScreenEvent extends MainScreenEvent {}

class SwitchIsGridEvent extends MainScreenEvent {
  final bool value;
  SwitchIsGridEvent(
    this.value,
  );
  @override
  List<Object> get props => [];
}

class SwitchTabEvent extends MainScreenEvent {
  final int tab;
  SwitchTabEvent(
    this.tab,
  );
  @override
  List<Object> get props => [];
}
