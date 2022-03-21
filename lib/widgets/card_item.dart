import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String? titulo;
  IconData? icon;
  final String? subtitle;
  Function()? onTap;

  CardItem({Key? key, this.titulo, this.icon, this.subtitle, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 120,
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Stack(
          children: [
            Container(
              height: 124,
              margin: const EdgeInsets.only(left: 36),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 10),
                    ),
                  ]),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              alignment: FractionalOffset.centerLeft,
              child: CircleAvatar(
                child: Center(
                  child: Icon(
                    icon ?? Icons.bookmarks_sharp,
                    size: 40,
                  ),
                ),
                backgroundColor: Theme.of(context).indicatorColor,
                radius: 40,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50),
              alignment: FractionalOffset.centerRight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AutoSizeText(
                    titulo ?? 'Titulo de la asignatura',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.right,
                    maxLines: 3,
                  ),
                  AutoSizeText(
                    subtitle ?? 'Subtitulo',
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.right,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
