import 'package:flutter/material.dart';

class CustomCircleButton extends StatelessWidget {
  final Function onTap;
  final Color bg;
  final Widget icon;

  CustomCircleButton({
    @required this.onTap,
    this.bg = Colors.black,
    @required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(17),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(50), color: bg),
        child: icon,
      ),
    );
  }
}
