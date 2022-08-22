import 'package:flutter/cupertino.dart';

class CupertinoThemeWidget extends StatelessWidget {
  final Brightness brightness;
  final Widget childWidget;

  const CupertinoThemeWidget({
    Key? key,
    required this.brightness,
    required this.childWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: CupertinoThemeData(
        brightness: brightness,
      ),
      child: childWidget,
    );
  }
}
