import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final bool? obscureText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final Color? cursorColor;
  final Widget? suffixIcon;
  final String? errorText;

  const TextFieldWidget(
      {Key? key,
      this.hintText,
      this.icon,
      this.obscureText,
      this.controller,
      this.onChanged,
      this.cursorColor,
      this.suffixIcon,
      this.errorText})
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
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontSize: 14,
          color: errorText != null
              ? errorColor
              : isDarkMode
                  ? Theme.of(context).primaryColorLight
                  : Theme.of(context).primaryColor,
        ),
        onChanged: onChanged ?? (value) {},
        cursorColor: errorText != null ? errorColor : cursorColor,
        obscureText: obscureText ?? false,
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
            labelText: hintText,
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
      ),
    );
  }
}
