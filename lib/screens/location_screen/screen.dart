import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricknmorty/components/blured_image.dart';
import 'package:ricknmorty/components/custom_app_bar.dart';
import 'package:ricknmorty/components/character_list_item.dart';
import 'package:ricknmorty/components/green_circle_loader.dart';
import 'package:ricknmorty/data/dummy.dart';
import 'package:ricknmorty/data/models/location.dart';
import 'package:ricknmorty/screens/location_screen/bloc/location_bloc.dart';
import 'package:ricknmorty/screens/location_screen/src/characters.dart';
import 'package:ricknmorty/screens/location_screen/src/info.dart';
import 'package:ricknmorty/theme/color_theme.dart';

class LocationScreen extends StatelessWidget {
  final String id;
  LocationScreen({this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      extendBodyBehindAppBar: true,
      body: BlocProvider(
        create: (context) => LocationBloc()..add(FetchLocationData(id)),
        child: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            switch (state.status) {
              case LocationStatus.failure:
                return const Center(child: Text('Ошибка при загрузке'));
              case LocationStatus.success:
                if (state.characters.isEmpty) {
                  return const SizedBox();
                }
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 300,
                        child: Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            BluredImage(img: state.location.imageName, blur: false),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 34,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(26),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      LocationInfo(state.location),
                      const SizedBox(height: 36),
                      LocationCharacters(state.characters),
                    ],
                  ),
                );
              default:
                return const Center(child: GreenCircleLoader());
            }
          },
        ),
      ),
    );
  }
}
