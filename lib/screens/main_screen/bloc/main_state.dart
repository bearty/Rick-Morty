part of 'main_bloc.dart';

abstract class MainScreenState extends Equatable {
  MainScreenState();
}

class MainScreenInitialState extends MainScreenState {
  MainScreenInitialState();

  @override
  List<Object> get props => [];
}

class MainScreenIsGridState extends MainScreenState {
  final bool isGrid;
  MainScreenIsGridState({this.isGrid});
  @override
  List<Object> get props => [isGrid];
}

class MainScreenTabState extends MainScreenState {
  final int tab;
  MainScreenTabState({this.tab});
  @override
  List<Object> get props => [tab];
}
