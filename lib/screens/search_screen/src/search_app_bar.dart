import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ricknmorty/resources/main_icons.dart';
import 'package:ricknmorty/screens/search_screen/search.dart';
import 'package:ricknmorty/theme/color_theme.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  SearchAppBar({
    Key key,
    this.text,
    @required this.onSearch,
    this.onClear,
    this.type,
  })  : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  final String text;
  final Function onSearch;
  final Function onClear;
  final SearchType type;

  @override
  final Size preferredSize;

  @override
  _SearchAppBarState createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  TextEditingController _textEditingController;

  var focusNode = FocusNode();
  String hintText = "Введите название";

  @override
  void initState() {
    super.initState();
    _textEditingController = new TextEditingController(text: widget.text);

    switch (widget.type) {
      case SearchType.character:
        setState(() => hintText = "Найти персонажа");
        break;
      case SearchType.location:
        setState(() => hintText = "Найти локацию");
        break;
      case SearchType.episode:
        setState(() => hintText = "Найти эпизод");
        break;
      default:
        setState(() => hintText = "Введите название");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      // leadingWidth: appBarHeight + 16,
      leading: IconButton(
        onPressed: () => Navigator.of(context).maybePop(),
        icon: SvgPicture.asset(
          MainIcons.back,
          color: Theme.of(context).accentColor,
        ),
      ),
      centerTitle: false,
      title: TextFormField(
        // controller: TextEditingController(),
        controller: _textEditingController,
        // initialValue: text,
        focusNode: focusNode,
        style: TextStyle(color: Theme.of(context).accentColor, fontSize: 16),
        cursorColor: Theme.of(context).accentColor,
        // onChanged: (change) => print(change),
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(FocusNode());
          widget.onSearch(_textEditingController.text);
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.gray),
          isDense: true,
        ),
      ),
      actions: [
        IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: () {
            _textEditingController.clear();
            FocusScope.of(context).requestFocus(focusNode);
            widget.onClear();
          },
          icon: SvgPicture.asset(
            MainIcons.disable,
            color: AppColors.gray,
          ),
        ),
      ],
    );
  }
}
