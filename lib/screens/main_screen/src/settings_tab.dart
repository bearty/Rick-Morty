import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:ricknmorty/bloc/bloc.dart';
import 'package:ricknmorty/resources/main_icons.dart';
import 'package:ricknmorty/screens/main_screen/src/settings_item.dart';
import 'package:ricknmorty/theme/color_theme.dart';
import 'package:ricknmorty/theme/theme_manager.dart';

class SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeVM = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      // appBar: CustomAppBar(noBack: true),
      body: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10),
        child: Column(
          children: [
            SettingsItem(
              name: "Внешний вид",
              leading: SvgPicture.asset(
                MainIcons.theme,
                color: Theme.of(context).accentColor,
              ),
              title: 'Темная тема',
              subtitle: Provider.of<ThemeNotifier>(context).getThemeName(),
              trailing: SvgPicture.asset(MainIcons.arrow, color: Theme.of(context).accentColor),
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
                            value: 0,
                            groupValue: Provider.of<ThemeNotifier>(context).getThemeId(),
                            activeColor: AppColors.lightBlue,
                            onChanged: (val) {
                              themeVM.setThemeStyle(val);
                              Navigator.pop(context, 'Cancel');
                            },
                          ),
                          RadioListTile(
                            title: Text(
                              'Включенна',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            value: 1,
                            groupValue: Provider.of<ThemeNotifier>(context).getThemeId(),
                            activeColor: AppColors.lightBlue,
                            onChanged: (val) {
                              themeVM.setThemeStyle(val);
                              Navigator.pop(context, 'Cancel');
                            },
                          ),
                          RadioListTile(
                            title: Text(
                              'Следовать настройкам системы',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            value: 2,
                            groupValue: Provider.of<ThemeNotifier>(context).getThemeId(),
                            activeColor: AppColors.lightBlue,
                            onChanged: (val) {
                              themeVM.setThemeStyle(val);
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
              title: 'Зигерионцы помещают Джерри и Рика в симуляцию, чтобы узнать секрет изготовления концентрированной темной материи.',
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
  }
}
