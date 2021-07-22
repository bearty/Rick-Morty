import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ricknmorty/data/models/character.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainScreenBloc() : super(MainScreenIsGridState(isGrid: false));

  int tab = 0;

  @override
  Stream<MainScreenState> mapEventToState(MainScreenEvent event) async* {
    if (event is InitialMainScreenEvent) {
      MainScreenIsGridState(isGrid: false);
    }
    if (event is SwitchIsGridEvent) {
      yield* _switchIsGrid(event);
    }
    if (event is SwitchTabEvent) {
      yield* _switchTab(event);
    }
  }

  Stream<MainScreenState> _switchIsGrid(SwitchIsGridEvent event) async* {
    yield MainScreenIsGridState(isGrid: event.value);
  }

  Stream<MainScreenState> _switchTab(SwitchTabEvent event) async* {
    yield MainScreenTabState(tab: event.tab);
  }
}
