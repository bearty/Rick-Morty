import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ricknmorty/components/filter_app_bar.dart';
import 'package:ricknmorty/components/filter_screen_item.dart';
import 'package:ricknmorty/components/green_circle_loader.dart';
import 'package:ricknmorty/resources/main_icons.dart';
import 'package:ricknmorty/screens/locations_filter_screen/src/location_filter_item.dart';
import 'package:ricknmorty/screens/main_screen/bloc/characters_bloc.dart';
import 'package:ricknmorty/screens/main_screen/bloc/locations_bloc.dart';
import 'package:ricknmorty/theme/color_theme.dart';

import 'choose_screen.dart';

class LocationsFilterScreen extends StatelessWidget {
  const LocationsFilterScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationsBloc, LocationsState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            BlocProvider.of<LocationsBloc>(context).add(LocationsApplyFilters());
            print('append will pop');
            return Future.delayed(Duration(milliseconds: 50), () => true);
          },
          child: Scaffold(
            appBar: FilterAppBar(
              title: 'Фильтры',
              right: state.measurementFilter.isNotEmpty || state.typeFilter.isNotEmpty || !state.sortForward
                  ? IconButton(
                      onPressed: () => context.read<LocationsBloc>()..add(LocationsResetFilters()),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                onPressed: () => context.read<LocationsBloc>()..add(LocationsSetSort(true)),
                                icon: SvgPicture.asset(
                                  MainIcons.sort_asc,
                                  color: state.sortForward ? ColorPalette.blue : ColorPalette.gray_text,
                                ),
                              ),
                              IconButton(
                                onPressed: () => context.read<LocationsBloc>()..add(LocationsSetSort(false)),
                                icon: SvgPicture.asset(
                                  MainIcons.sort_des,
                                  color: !state.sortForward ? ColorPalette.blue : ColorPalette.gray_text,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: ColorPalette.widget_bg,
                      height: 72,
                      thickness: 2,
                    ),
                    Text(
                      'Фильтровать по'.toUpperCase(),
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 10, color: ColorPalette.gray_text, letterSpacing: 1.5),
                    ),
                    SizedBox(height: 36),
                    LocationFilterItem(
                      title: state.typeFilter == '' ? 'Тип' : state.typeFilter,
                      subtitle: 'Выберите тип локации',
                      onPress: () => Navigator.pushNamed(context, '/locations-filter-choose', arguments: {'choose': LocationFilter.type}),
                    ),
                    SizedBox(height: 36),
                    LocationFilterItem(
                      title: state.measurementFilter == '' ? 'Измерение' : state.measurementFilter,
                      subtitle: 'Выберите измерения локации',
                      onPress: () => Navigator.pushNamed(context, '/locations-filter-choose', arguments: {'choose': LocationFilter.measurement}),
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
