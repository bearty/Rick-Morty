import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ricknmorty/components/filter_app_bar.dart';
import 'package:ricknmorty/components/filter_screen_item.dart';
import 'package:ricknmorty/components/green_circle_loader.dart';
import 'package:ricknmorty/resources/main_icons.dart';
import 'package:ricknmorty/screens/main_screen/bloc/characters_bloc.dart';
import 'package:ricknmorty/theme/color_theme.dart';

class CharactersFilterScreen extends StatelessWidget {
  const CharactersFilterScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharactersBloc, CharactersState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            // context.read<CharactersBloc>()..add(CharactersApplyFilters());
            BlocProvider.of<CharactersBloc>(context).add(CharactersApplyFilters());
            print('append will pop');
            return Future.delayed(Duration(milliseconds: 50), () => true);
          },
          child: Scaffold(
            appBar: FilterAppBar(
              title: 'Фильтры',
              right: state.filterGender.isNotEmpty || state.filterStatus.isNotEmpty || !state.sortForward
                  ? IconButton(
                      onPressed: () => context.read<CharactersBloc>()..add(CharactersResetFilters()),
                      icon: SvgPicture.asset(
                        MainIcons.disable_filter,
                      ),
                    )
                  : null,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  children: [
                    FilterItem(
                      title: 'Сортировать',
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('По Алфавиту', style: TextStyle(fontSize: 16)),
                          ButtonBar(
                            children: [
                              IconButton(
                                onPressed: () => context.read<CharactersBloc>()..add(CharactersSetSort(true)),
                                icon: SvgPicture.asset(
                                  MainIcons.sort_asc,
                                  color: state.sortForward ? AppColors.blue : AppColors.gray,
                                ),
                              ),
                              IconButton(
                                onPressed: () => context.read<CharactersBloc>()..add(CharactersSetSort(false)),
                                icon: SvgPicture.asset(
                                  MainIcons.sort_des,
                                  color: !state.sortForward ? AppColors.blue : AppColors.gray,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).dividerColor,
                      height: 72,
                      thickness: 2,
                    ),
                    FilterItem(
                      title: 'Статус',
                      subtitle: Column(
                        children: [
                          CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text('Живой', style: TextStyle(color: Theme.of(context).accentColor, fontSize: 16)),
                            checkColor: Theme.of(context).scaffoldBackgroundColor,
                            activeColor: AppColors.blue,
                            value: state.filterStatus.contains(0),
                            contentPadding: EdgeInsets.all(0),
                            onChanged: (bool val) => context.read<CharactersBloc>()..add(CharactersSetStatusFilter(0)),
                          ),
                          CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text('Мёртвый', style: TextStyle(color: Theme.of(context).accentColor, fontSize: 16)),
                            checkColor: Theme.of(context).scaffoldBackgroundColor,
                            activeColor: AppColors.blue,
                            value: state.filterStatus.contains(1),
                            contentPadding: EdgeInsets.all(0),
                            onChanged: (bool val) => context.read<CharactersBloc>()..add(CharactersSetStatusFilter(1)),
                          ),
                          CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text('Неизвестно', style: TextStyle(color: Theme.of(context).accentColor, fontSize: 16)),
                            checkColor: Theme.of(context).scaffoldBackgroundColor,
                            activeColor: AppColors.blue,
                            value: state.filterStatus.contains(2),
                            contentPadding: EdgeInsets.all(0),
                            onChanged: (bool val) => context.read<CharactersBloc>()..add(CharactersSetStatusFilter(2)),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).dividerColor,
                      height: 72,
                      thickness: 2,
                    ),
                    FilterItem(
                      title: 'Пол',
                      subtitle: Column(
                        children: [
                          CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text('Мужской', style: TextStyle(color: Theme.of(context).accentColor, fontSize: 16)),
                            checkColor: Theme.of(context).scaffoldBackgroundColor,
                            activeColor: AppColors.blue,
                            value: state.filterGender.contains(0),
                            contentPadding: EdgeInsets.all(0),
                            onChanged: (bool val) => context.read<CharactersBloc>()..add(CharactersSetGenderFilter(0)),
                          ),
                          CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text('Женский', style: TextStyle(color: Theme.of(context).accentColor, fontSize: 16)),
                            checkColor: Theme.of(context).scaffoldBackgroundColor,
                            activeColor: AppColors.blue,
                            value: state.filterGender.contains(1),
                            contentPadding: EdgeInsets.all(0),
                            onChanged: (bool val) => context.read<CharactersBloc>()..add(CharactersSetGenderFilter(1)),
                          ),
                          CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text('Бесполый', style: TextStyle(color: Theme.of(context).accentColor, fontSize: 16)),
                            checkColor: Theme.of(context).scaffoldBackgroundColor,
                            activeColor: AppColors.blue,
                            value: state.filterGender.contains(2),
                            contentPadding: EdgeInsets.all(0),
                            onChanged: (bool val) => context.read<CharactersBloc>()..add(CharactersSetGenderFilter(2)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
