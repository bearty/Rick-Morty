import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricknmorty/components/green_circle_loader.dart';
import 'package:ricknmorty/data/dummy.dart';
import 'package:ricknmorty/screens/main_screen/bloc/locations_bloc.dart';
import 'package:ricknmorty/screens/main_screen/src/location_item.dart';
import 'package:ricknmorty/screens/main_screen/src/search.dart';
import 'package:ricknmorty/screens/main_screen/src/search_bar_bottom.dart';
import 'package:ricknmorty/screens/search_screen/search.dart';
import 'package:ricknmorty/theme/color_theme.dart';

class LocationsTab extends StatelessWidget {
  const LocationsTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationsBloc, LocationsState>(builder: (context, state) {
      switch (state.status) {
        case LocationsStatus.failure:
          return const Center(child: Text('Ошибка при загрузке'));
        case LocationsStatus.success:
          if (state.allLocations.isEmpty) {
            return const Center(child: Text('Список пуст'));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              title: SearchBar(
                  placeholder: "Найти локацию",
                  onFilter: () => Navigator.pushNamed(context, '/locations-filter'),
                  onSearch: (String text) {
                    context.read<LocationsBloc>()..add(LocationsSearch(text));
                    Navigator.pushNamed(context, '/search', arguments: {'type': SearchType.location, 'text': text, 'data': state.allLocations});
                  }),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(50.0),
                child: SearchBarBottom(
                  text: 'ВСЕГО ЛОКАЦИЙ: ${state.total}',
                ),
              ),
            ),
            body: NotificationListener<ScrollEndNotification>(
              onNotification: (ScrollEndNotification scrollEnd) {
                var metrics = scrollEnd.metrics;
                if (metrics.atEdge) {
                  if (metrics.pixels == 0)
                    print('At top');
                  else {
                    print('At bottom');
                    // context.read<LocationsBloc>()..add(LocationsFetch());
                  }
                }
                return true;
              },
              child: state.locations.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/filter_not_finded.png'),
                          Text(
                            'По данным фильтра ничего \nне найдено',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: ColorPalette.gray_text, fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.locations.length,
                        itemBuilder: (context, index) => LocationItem(state.locations[index]),
                        separatorBuilder: (BuildContext context, int index) => SizedBox(height: 24),
                      ),
                    ),
            ),
          );
        default:
          return const Center(child: GreenCircleLoader());
      }
    });
  }
}
