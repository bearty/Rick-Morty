import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ricknmorty/data/dummy.dart';
import 'package:ricknmorty/resources/main_icons.dart';
import 'package:ricknmorty/screens/main_screen/src/episodes_tab.dart';
import 'package:ricknmorty/screens/main_screen/src/locations_tab.dart';
import 'package:ricknmorty/screens/main_screen/src/characters_tab.dart';
import 'package:ricknmorty/screens/main_screen/src/search_bar_bottom.dart';
import 'package:ricknmorty/screens/main_screen/src/search.dart';
import 'package:ricknmorty/screens/main_screen/src/settings_tab.dart';
import 'package:ricknmorty/theme/color_theme.dart';

import 'bloc/characters_bloc.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
  }

  void onSelectTab(int i) {
    setState(() {
      _selectedTab = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        CharactersTab(),
        LocationsTab(),
        EpisodesTab(),
        SettingsTab(),
      ].elementAt(_selectedTab),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              MainIcons.character,
              color: _selectedTab == 0 ? Theme.of(context).textTheme.bodyText2.color : Theme.of(context).textTheme.subtitle2.color,
            ),
            label: 'Персонажи',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              MainIcons.location,
              color: _selectedTab == 1 ? Theme.of(context).textTheme.bodyText2.color : Theme.of(context).textTheme.subtitle2.color,
            ),
            label: 'Локации',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              MainIcons.episode,
              color: _selectedTab == 2 ? Theme.of(context).textTheme.bodyText2.color : Theme.of(context).textTheme.subtitle2.color,
            ),
            label: 'Эпизоды',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              MainIcons.settings,
              color: _selectedTab == 3 ? Theme.of(context).textTheme.bodyText2.color : Theme.of(context).textTheme.subtitle2.color,
            ),
            label: 'Настройки',
          ),
        ],
        currentIndex: _selectedTab,
        selectedItemColor: Theme.of(context).textTheme.bodyText2.color,
        unselectedItemColor: Theme.of(context).textTheme.subtitle2.color,
        selectedLabelStyle: TextStyle(fontSize: 12),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        backgroundColor: Theme.of(context).accentColor,
        onTap: (i) => onSelectTab(i),
      ),
    );
  }
}
