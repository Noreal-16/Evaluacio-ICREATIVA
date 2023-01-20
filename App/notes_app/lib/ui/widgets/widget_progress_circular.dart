import 'package:flutter/material.dart';
import 'package:notes_app/ui/utils/app_color.dart';

class WidgetProgressCircular extends StatelessWidget {
  final Color color;

  const WidgetProgressCircular({Key? key, this.color = AppColor.colorprimary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(color),
    );
  }
}
