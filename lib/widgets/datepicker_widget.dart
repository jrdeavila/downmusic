import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatelessWidget {
  final String? errorText, hintText;
  final IconData? icon;
  final DateTime? initialDate;
  final void Function(DateTime?) onChanged;
  final Widget? suffixIcon;
  const DatePickerWidget(
      {Key? key,
      this.errorText,
      this.hintText,
      this.icon,
      this.initialDate,
      required this.onChanged,
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
      child: DateTimeField(
          style: TextStyle(
            fontSize: 14,
            color: errorText != null
                ? errorColor
                : isDarkMode
                    ? Theme.of(context).primaryColorLight
                    : Theme.of(context).primaryColor,
          ),
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
          onChanged: onChanged,
          format: DateFormat('yyyy-MM-dd'),
          onShowPicker: (context, currentValue) {
            return showDatePicker(
                context: context,
                initialDate: currentValue ?? initialDate ?? DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100));
          }),
    );
  }
}
