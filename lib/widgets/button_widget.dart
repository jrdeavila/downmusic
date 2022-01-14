import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String? title;
  final bool hasBorder;
  final Function()? onTap;
  final Color? color;
  final IconData? icon;
  final Color? textColor;
  const ButtonWidget({Key? key, this.title, this.hasBorder = false, this.onTap, this.color, this.icon, this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var fColor = hasBorder ? textColor ?? Theme.of(context).primaryColor : isDarkMode ? Theme.of(context).primaryColorLight : textColor ?? Colors.white;
    var bgColor = hasBorder ? isDarkMode ? Theme.of(context).primaryColorLight : Colors.white : color ?? Theme.of(context).primaryColor;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Material(
        child: Ink(
          decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: hasBorder ? Border.all(color: color ?? Theme.of(context).primaryColor, width: 1) : const Border.fromBorderSide(BorderSide.none),
            ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
             height: 60,
              child: Center(
                child: SizedBox(
                width: 250,
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (icon != null) Icon(icon!, size: 40, color: fColor),
                      Text(
                        title ?? '',
                        style: TextStyle(
                          color: fColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
