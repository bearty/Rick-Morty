import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ricknmorty/resources/main_icons.dart';
import 'package:ricknmorty/theme/color_theme.dart';

class SearchBarBottom extends StatefulWidget {
  final Function onPress;
  final bool isGrid;
  final bool showLoader;
  final String text;
  SearchBarBottom({
    Key key,
    this.onPress,
    this.isGrid,
    this.showLoader = false,
    @required this.text,
  }) : super(key: key);

  @override
  _SearchBarBottomState createState() => _SearchBarBottomState();
}

class _SearchBarBottomState extends State<SearchBarBottom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.text}',
                  style: TextStyle(
                    fontSize: 10,
                    color: ColorPalette.gray_text,
                  ),
                ),
                widget.onPress == null
                    ? const SizedBox()
                    : IconButton(
                        onPressed: widget.onPress,
                        icon: SvgPicture.asset(
                          widget.isGrid ? MainIcons.grid : MainIcons.list,
                          color: ColorPalette.gray_text,
                        ),
                      ),
              ],
            ),
          ),
          !widget.showLoader
              ? const SizedBox()
              : LinearProgressIndicator(minHeight: 1, color: ColorPalette.green, backgroundColor: ColorPalette.blue),
        ],
      ),
    );
  }
}
