import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ricknmorty/theme/color_theme.dart';

class BluredImage extends StatelessWidget {
  final String img;
  final bool blur;

  BluredImage({this.img, this.blur = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          img,
          fit: BoxFit.cover,
        ),
        !blur
            ? const SizedBox()
            : ClipRRect(
                // Clip it cleanly.
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(
                    color: Colors.grey.withOpacity(0.1),
                    alignment: Alignment.center,
                  ),
                ),
              ),
        !blur
            ? const SizedBox()
            : Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.3],
                    colors: [Colors.black.withOpacity(0.65), Colors.transparent],
                  ),
                ),
              ),
        !blur
            ? const SizedBox()
            : Container(
                decoration: BoxDecoration(
                  color: ColorPalette.bg.withOpacity(0.65),
                ),
              ),
      ],
    );
  }
}
