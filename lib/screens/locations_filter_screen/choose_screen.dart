import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ricknmorty/components/filter_app_bar.dart';
import 'package:ricknmorty/components/filter_screen_item.dart';
import 'package:ricknmorty/resources/main_icons.dart';
import 'package:ricknmorty/screens/main_screen/bloc/characters_bloc.dart';
import 'package:ricknmorty/screens/main_screen/bloc/locations_bloc.dart';
import 'package:ricknmorty/theme/color_theme.dart';

import 'src/choose_filter_item.dart';

enum LocationFilter { measurement, type }

class LocationsFilterChooseScreen extends StatelessWidget {
  const LocationsFilterChooseScreen({Key key, @required this.choose}) : super(key: key);

  final LocationFilter choose;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationsBloc, LocationsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: FilterAppBar(
            title: choose == LocationFilter.type ? "Выберите тип" : "Выберите измерение",
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [
                  ChooseFilterItem(
                      name: 'Не выбрано',
                      selected: false,
                      onPress: () {
                        if (choose == LocationFilter.type) return context.read<LocationsBloc>()..add(SetLocationTypeFilter(''));
                        return context.read<LocationsBloc>()..add(SetLocationMeasurementFilter(''));
                      }),
                  Divider(
                    color: Theme.of(context).dividerColor,
                    height: 48,
                    thickness: 2,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: choose == LocationFilter.type ? state.locationTypes.length : state.locationMeasurements.length,
                    itemBuilder: (context, index) {
                      if (choose == LocationFilter.type) {
                        return ChooseFilterItem(
                          name: state.locationTypes[index],
                          selected: state.typeFilter == state.locationTypes[index],
                          onPress: () => context.read<LocationsBloc>()..add(SetLocationTypeFilter(state.locationTypes[index])),
                        );
                      } else {
                        return ChooseFilterItem(
                          name: state.locationMeasurements[index],
                          selected: state.measurementFilter == state.locationMeasurements[index],
                          onPress: () => context.read<LocationsBloc>()..add(SetLocationMeasurementFilter(state.locationMeasurements[index])),
                        );
                      }
                    },
                    // separatorBuilder: (BuildContext context, int index) => SizedBox(height: 24),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
