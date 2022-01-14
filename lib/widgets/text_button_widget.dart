import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  final Function()? onTap;
  final String title;
  const TextButtonWidget({Key? key, this.onTap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: TextButton(
          onPressed: onTap,
          child: Text(title,
              style: TextStyle(
                fontSize: 18,
                color: isDarkTheme
                    ? Colors.white
                    : Theme.of(context).primaryColor
              ))),
    );
  }
}
