import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ricknmorty/bloc/bloc.dart';
import 'package:ricknmorty/resources/main_icons.dart';
import 'package:ricknmorty/screens/main_screen/src/settings_item.dart';
import 'package:ricknmorty/theme/color_theme.dart';

class SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      String themeText = 'Выберите тему';

      switch (state.themeMode) {
        case ThemeMode.dark:
          themeText = 'Включена';
          break;
        case ThemeMode.light:
          themeText = 'Выключенна';
          break;
        case ThemeMode.system:
          themeText = 'Следовать настройкам системы';
          break;
        default:
          themeText = 'Выберите тему';
      }

      return Scaffold(
        // appBar: CustomAppBar(noBack: true),
        body: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 10),
          child: Column(
            children: [
              SettingsItem(
                name: "Внешний вид",
                leading: SvgPicture.asset(MainIcons.theme),
                title: 'Темная тема',
                subtitle: themeText,
                trailing: SvgPicture.asset(MainIcons.arrow),
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => StatefulBuilder(
                    builder: (context, setState) => AlertDialog(
                      contentPadding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      title: Text('Темная тема', style: TextStyle(fontSize: 20)),
                      content: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            RadioListTile(
                              title: Text(
                                'Выключенна',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              value: ThemeMode.light,
                              groupValue: state.themeMode,
                              onChanged: (ThemeMode val) {
                                context.read<ThemeBloc>()..add(SelectedThemeEvent(0));
                                Navigator.pop(context, 'Cancel');
                              },
                            ),
                            RadioListTile(
                              title: Text(
                                'Включенна',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              value: ThemeMode.dark,
                              groupValue: state.themeMode,
                              activeColor: ColorPalette.blue,
                              onChanged: (ThemeMode val) {
                                context.read<ThemeBloc>()..add(SelectedThemeEvent(1));
                                Navigator.pop(context, 'Cancel');
                              },
                            ),
                            RadioListTile(
                              title: Text(
                                'Следовать настройкам системы',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              value: ThemeMode.system,
                              groupValue: state.themeMode,
                              onChanged: (ThemeMode val) {
                                context.read<ThemeBloc>()..add(SelectedThemeEvent(2));
                                Navigator.pop(context, 'Cancel');
                              },
                            ),
                            /*RadioListTile(
                          title: Text(
                            'В режиме энергосбережения',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          value: 3,
                          groupValue: 1,
                          onChanged: (val) => print('Change to $val'),
                        ),*/
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: Text('ОТМЕНА', style: Theme.of(context).textTheme.button),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // const SizedBox(height: 36),
              SettingsItem(
                name: "О приложении",
                title: 'Зигерионцы помещают Джерри и Рика в симуляцию, чтобы узнать секрет изготовления концен-трирован- ной темной материи.',
              ),
              SettingsItem(
                name: "Версия приложения",
                title: 'Rick & Morty  v1.0.0',
                bottomDivider: false,
              ),
            ],
          ),
        ),
      );
    });
  }
}
