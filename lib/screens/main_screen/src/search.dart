import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ricknmorty/resources/main_icons.dart';
import 'package:ricknmorty/theme/color_theme.dart';

class SearchBar extends StatelessWidget {
  final Function onFilter;
  final Function onSearch;
  final String placeholder;
  final TextEditingController _textEditingController = new TextEditingController();
  SearchBar({@required this.onSearch, this.onFilter, this.placeholder = 'Поиск'});

  @override
  Widget build(BuildContext context) {
    void onPressSomeButton(Function fn) {
      FocusScope.of(context).unfocus();
      FocusScope.of(context).canRequestFocus = false;
      Future.delayed(Duration(milliseconds: 100), () {
        FocusScope.of(context).canRequestFocus = true;
      });
      fn();
    }

    return TextFormField(
      // controller: TextEditingController(),
      controller: _textEditingController,
      focusNode: FocusNode(),
      style: TextStyle(color: ColorPalette.gray_text),
      cursorColor: ColorPalette.gray_text,
      // onChanged: (change) => print(change),
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        onSearch(_textEditingController.text);
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        fillColor: Theme.of(context).accentColor,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        hintText: "$placeholder",
        hintStyle: TextStyle(color: ColorPalette.gray_text),
        isDense: true,
        prefixIcon: IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          icon: SvgPicture.asset(
            MainIcons.search,
            color: ColorPalette.gray_text,
          ),
          onPressed: null,
        ),
        suffixIcon: onFilter == null
            ? const SizedBox()
            : IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    VerticalDivider(
                      color: Colors.white.withOpacity(.1),
                      indent: 12,
                      endIndent: 12,
                      width: 1,
                      thickness: 1,
                    ),
                    IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onPressed: () => onPressSomeButton(onFilter),
                      icon: SvgPicture.asset(
                        MainIcons.filter,
                        color: ColorPalette.gray_text,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
