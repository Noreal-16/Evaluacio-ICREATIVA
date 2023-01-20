import 'package:flutter/material.dart';
import 'package:notes_app/ui/utils/app_color.dart';
import 'package:notes_app/ui/utils/global_variable.dart';
import 'package:notes_app/ui/widgets/widget_button.dart';

Future WidgetAlertMessage(BuildContext context,msj, VoidCallback? callBack,
    {VoidCallback? callBackCancel,
    title,
    textAccept = "Aceptar",
    textCancelar = "Cancelar",
      Color colorBtnAccept= AppColor.colorprimary,
      Color colorBtnCancel= AppColor.colorsecondary,
    activeCancel = false,
    required iconAlert}) async {
  return showDialog<void>(
    context: context,// GlobalUtils.globalContext.currentContext!,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Image.asset(
                "${GlobalVariable.assetalert}$iconAlert",
                width: 64,
                height: 64,
                fit: BoxFit.contain,
              ),
              if (title!=null) ...[
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.colorprimary,
                        fontFamily: GlobalVariable.lettertitle,
                        fontSize: 20),
                  ),
                ),
              ],
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  msj,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      color: AppColor.colorprimary,
                      fontFamily: GlobalVariable.lettersubtitle,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Column(
            children: [
              WidgetButton(
                  text: textAccept,
                  color:  colorBtnAccept,
                  onTap: () {
                    Navigator.of(context).pop();
                    callBack!();
                  }),
              if (activeCancel) ...[
                const SizedBox(
                  height: 10,
                ),
                WidgetButton(
                  text: textCancelar,
                  color: colorBtnCancel,
                  colorText: AppColor.colorwhite,
                  colorBorder: AppColor.colorlettertitle,
                  onTap: () {
                    Navigator.of(context).pop();
                    if (callBackCancel != null) {
                      callBackCancel();
                    }
                  },
                ),
              ]
            ],
          ),
        ],
      );
    },
  );
}
