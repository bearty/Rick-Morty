import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:ricknmorty/screens/characters_filter_screen/screen.dart';
import 'package:ricknmorty/screens/episode_screen/screen.dart';
import 'package:ricknmorty/screens/location_screen/screen.dart';
import 'package:ricknmorty/screens/locations_filter_screen/choose_screen.dart';
import 'package:ricknmorty/screens/locations_filter_screen/screen.dart';
import 'package:ricknmorty/screens/main_screen/bloc/episodes_bloc.dart';
import 'package:ricknmorty/screens/main_screen/bloc/locations_bloc.dart';
import 'package:ricknmorty/screens/main_screen/bloc/characters_bloc.dart';
import 'package:ricknmorty/screens/main_screen/screen.dart';
import 'package:ricknmorty/screens/character_screen/screen.dart';
import 'package:ricknmorty/screens/search_screen/bloc/search_bloc.dart';
import 'package:ricknmorty/screens/search_screen/search.dart';
import 'package:ricknmorty/theme/color_theme.dart';
import 'package:ricknmorty/theme/main_theme.dart';
import 'package:ricknmorty/theme/text_theme.dart';
import 'package:ricknmorty/theme/theme_manager.dart';

import 'bloc/bloc.dart';
import 'data/repository.dart';

void main() {
  initializeDateFormatting();
  return runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => ThemeNotifier(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider<Repository>(create: (_) => Repository()..init())],
      child: Consumer<ThemeNotifier>(
        builder: (context, theme, _) => MultiBlocProvider(
          providers: [
            BlocProvider<CharactersBloc>(create: (context) => CharactersBloc()..add(CharactersFetch())),
            BlocProvider<EpisodesBloc>(create: (context) => EpisodesBloc()..add(EpisodesFetch())),
            BlocProvider<LocationsBloc>(create: (context) => LocationsBloc()..add(LocationsFetch())),
            BlocProvider<SearchBloc>(create: (context) => SearchBloc()),
          ],
          child: AnnotatedRegion(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: theme.getThemeMode() == ThemeMode.light ? Brightness.light : Brightness.dark,
            ),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Rick & Morty',
              theme: theme.getTheme(),
              // darkTheme: darkTheme,
              // themeMode: state.themeMode,
              home: SplashScreen(),
              onGenerateRoute: (settings) {
                String name = settings.name;
                Map arg = settings.arguments;
                if (name == '/main') {
                  return PageTransition(type: PageTransitionType.fade, child: MainScreen(), duration: Duration(seconds: 1));
                  // return CupertinoPageRoute(builder: (_) => MainScreen());
                }
                if (name == '/characters-filter') {
                  return CupertinoPageRoute(builder: (_) => CharactersFilterScreen());
                  // return CupertinoPageRoute(builder: (_) => MainScreen());
                }
                if (name == '/character') {
                  return CupertinoPageRoute(builder: (_) => CharacterScreen(id: arg['id']));
                }
                if (name == '/locations-filter') {
                  return CupertinoPageRoute(builder: (_) => LocationsFilterScreen());
                  // return CupertinoPageRoute(builder: (_) => MainScreen());
                }
                if (name == '/locations-filter-choose') {
                  return CupertinoPageRoute(builder: (_) => LocationsFilterChooseScreen(choose: arg['choose']));
                  // return CupertinoPageRoute(builder: (_) => MainScreen());
                }

                if (name == '/location') {
                  return CupertinoPageRoute(
                    builder: (_) => LocationScreen(id: arg['id']),
                  );
                }
                if (name == '/episode') {
                  return CupertinoPageRoute(
                    builder: (_) => EpisodeScreen(id: arg['id']),
                  );
                }
                if (name == '/search') {
                  return CupertinoPageRoute(
                    builder: (_) => SearchScreen(type: arg['type']),
                  );
                }

                return null;
              },
            ),
          ),
        ),
      ),
    );

    /// Делаем доступным блок в дереве виджетов
    /*return BlocProvider<ThemeBloc>(
      create: (BuildContext contextBloc) =>
          ThemeBloc()..add(InitialThemeEvent()),

      /// Обрабатываем состояния
      child: 
    );*/
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer _timer;
  bool go = false;
  String characterImg = Random().nextInt(2) == 0 ? "assets/images/splash_characters.png" : "assets/images/splash_characters_2.png";

  @override
  void initState() {
    super.initState();
    _goByTimer();
  }

  _goByTimer() {
    _timer = new Timer(const Duration(milliseconds: 2000), () {
      if (!go) _goToMainScreen();
    });
  }

  _goToMainScreen() {
    setState(() => go = true);
    Navigator.pushReplacementNamed(context, '/main');
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _goToMainScreen(),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryDark,
          image: DecorationImage(
            image: AssetImage('assets/images/splash_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Image(
                image: AssetImage('assets/images/splash_logo.png'),
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Image(
                image: AssetImage(characterImg),
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
