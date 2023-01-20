import 'package:flutter/material.dart';
import 'package:notes_app/ui/utils/app_color.dart';
import 'package:notes_app/ui/utils/global_variable.dart';

class WidgetButton extends StatelessWidget {
  final String text;
  final String icon;
  final Color color;
  final Function? onTap;
  final Color colorText;
  final Color colorBorder;
  final double sizeText;

  const WidgetButton(
      {Key? key,
      required this.text,
      required this.color,
      required this.onTap,
      this.colorText = Colors.white,
      this.colorBorder = Colors.transparent,
      this.sizeText = 18,
      this.icon = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: color,
              foregroundColor: color,
              surfaceTintColor: Colors.white,
              shape: RoundedRectangleBorder(
                side:  const BorderSide(color: AppColor.colorbackgroundPlace, width: 1),
                borderRadius: BorderRadius.circular(10),
              )),
          onPressed: onTap == null ? null : () => onTap!(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != ""
                  ? Image.asset(
                      "${GlobalVariable.asseticons}$icon",
                      width: 50,
                      height: 27,
                      fit: BoxFit.contain,
                    )
                  : const SizedBox(),
              Text( text, style: TextStyle(color: colorText),),
            ],
          )),
    );
  }
}
