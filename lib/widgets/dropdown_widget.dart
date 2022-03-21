import 'package:flutter/material.dart';

class DropdownWidget<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final String? hintText;
  final String? errorText;
  final void Function(T?) onChanged;
  final IconData? icon;

  final Widget? suffixIcon;
  const DropdownWidget(
      {Key? key,
      required this.items,
      this.hintText,
      required this.onChanged,
      this.errorText,
      this.icon,
      this.suffixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var errorColor = Theme.of(context).errorColor;
    var errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: errorColor),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: DropdownButtonFormField<T>(
          decoration: InputDecoration(
              prefixIcon: icon != null
                  ? errorText != null
                      ? Icon(icon, size: 18, color: errorColor)
                      : (isDarkMode
                          ? Icon(icon,
                              size: 18,
                              color: Theme.of(context).primaryColorLight)
                          : Icon(icon,
                              size: 18, color: Theme.of(context).primaryColor))
                  : null,
              filled: true,
              labelText: hintText,
              errorBorder: errorBorder,
              focusedErrorBorder: errorBorder,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: isDarkMode
                          ? Theme.of(context).primaryColorLight
                          : Theme.of(context).primaryColor)),
              enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              errorText: errorText,
              labelStyle: TextStyle(
                fontSize: 14,
                color: errorText != null
                    ? errorColor
                    : isDarkMode
                        ? Theme.of(context).primaryColorLight
                        : Theme.of(context).primaryColor,
              ),
              suffixIcon: suffixIcon),
          style: TextStyle(
            fontSize: 14,
            color: errorText != null
                ? errorColor
                : isDarkMode
                    ? Theme.of(context).primaryColorLight
                    : Theme.of(context).primaryColor,
          ),
          items: items,
          onChanged: onChanged),
    );
  }
}
