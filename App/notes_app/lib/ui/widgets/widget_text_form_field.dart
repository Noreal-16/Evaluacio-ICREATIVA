import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes_app/ui/utils/app_color.dart';
import 'package:notes_app/ui/utils/global_variable.dart';

class WidgetTextFormField extends StatefulWidget {
  final String hintText;
  final String labelTitle;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final bool obscureText,
      borderEnable,
      enable,
      autocorrect,
      colorWhenFocus,
      isLabelActive;

  final TextEditingController? controller;

  final double fontSize;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function()? onTapSufixIcon;
  final void Function(bool)? onFocusChanged;
  final String? Function(String?)? validator;
  final Icon? prefixIcon;
  final Image? imagePrefix;
  final Icon? suffixIcon;
  final FocusNode? focus;
  final int maxLines;
  final EdgeInsets padding;

  //parametros para favoritos
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autovalidateMode;

  final bool showClean;

  const WidgetTextFormField(
      {Key? key,
      this.hintText = '',
      required this.labelTitle,
      this.keyboardType = TextInputType.text,
      this.textCapitalization = TextCapitalization.none,
      this.obscureText = false,
      this.borderEnable = true,
      this.colorWhenFocus = false,
      this.isLabelActive = true,
      this.enable = true,
      this.fontSize = 13,
      this.controller,
      this.onChanged,
      this.onTap,
      this.onTapSufixIcon,
      this.validator,
      this.prefixIcon,
      this.imagePrefix,
      this.suffixIcon,
      this.focus,
      this.inputFormatters,
      this.autovalidateMode,
      this.maxLines = 1,
        this.onFocusChanged,
        this.padding = const EdgeInsets.all(20),
      this.autocorrect = true,
      this.showClean = false})
      : super(key: key);

  @override
  State<WidgetTextFormField> createState() => _WidgetTextFormFieldState();
}

class _WidgetTextFormFieldState extends State<WidgetTextFormField> {
  bool focused = false;
  bool showIconClean = false;
  bool isSelectedText=false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus != focused) {
        setState(() {
          focused = _focusNode.hasFocus;
          if(widget.colorWhenFocus){
            isSelectedText=focused;
          }
        });
        if(widget.onFocusChanged != null) widget.onFocusChanged!(_focusNode.hasFocus);
      }
    });
    // if(widget.controller)
    // widget.controller?.addListener(() {
    //   widget.onChanged!(widget.controller?.text ?? "");
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.isLabelActive
              ? Container(
                  margin: const EdgeInsets.only(left: 15, bottom: 5),
                  child: Text(
                    widget.labelTitle,
                    style: const TextStyle(
                        color: AppColor.colorgrey70,
                        fontFamily: GlobalVariable.lettersubtitle,
                        fontSize: 12),
                  ))
              : const SizedBox(),
          TextFormField(
            focusNode: widget.focus ?? _focusNode,
            enabled: widget.enable,
            inputFormatters: widget.inputFormatters,
            autovalidateMode: widget.autovalidateMode,
            autocorrect: widget.autocorrect,
            onTap: widget.onTap,
            textCapitalization: widget.textCapitalization,
            controller: widget.controller,
            obscureText: widget.obscureText,
            maxLines: widget.maxLines,
            keyboardType: widget.keyboardType,
            onChanged: (value){
              if(widget.onChanged != null){
                widget.onChanged!(value);
              }
              setState(() {
                showIconClean = value.isNotEmpty;
              });
            },
            validator: widget.validator,
            cursorColor: Theme.of(context).primaryColor,
            style: TextStyle(
                fontSize: widget.fontSize,
                color: Theme.of(context).primaryColor,
                fontFamily: GlobalVariable.lettersubtitle),
            decoration: InputDecoration(
              filled: true,
              fillColor: isSelectedText
                  ? AppColor.colorfocus
                  : AppColor.colorfillcolor,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              enabledBorder: widget.borderEnable
                  ? OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[200]!),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)))
                  : InputBorder.none,
              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsetsDirectional.only(start: 12),
                      child: widget.prefixIcon,
                    )
                  : null,
              suffixIcon: widget.showClean ? ( showIconClean ? Padding(
                padding: const EdgeInsetsDirectional.only(end: 12),
                child: GestureDetector(
                    onTap: (){
                      if(widget.onTapSufixIcon != null) widget.onTapSufixIcon!();
                      widget.controller?.clear();
                      setState(() {
                        showIconClean = false;
                      });
                    },
                    child: widget.suffixIcon),
              ) : null) : widget.suffixIcon != null
                      ? Padding(
                          padding: const EdgeInsetsDirectional.only(end: 12),
                          child: GestureDetector(
                              onTap: widget.onTapSufixIcon,
                              child: widget.suffixIcon),
                        )
                      : null,
              hintText: widget.hintText,
              focusColor: AppColor.colorfocus,
              hintStyle: const TextStyle(color: AppColor.colorhintstyletext),
              labelStyle: const TextStyle(fontWeight: FontWeight.w500),
              errorStyle: const TextStyle(color: Colors.red),
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColor.colorhintstyletext.withOpacity(0.2)),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0))),
              focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
            ),
          ),
        ],
      ),
    );
  }
}
