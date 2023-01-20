import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes_app/ui/providers/provider_general.dart';
import 'package:notes_app/ui/providers/provider_login.dart';
import 'package:notes_app/ui/utils/app_color.dart';
import 'package:notes_app/ui/utils/global_variable.dart';
import 'package:notes_app/ui/widgets/widget_alert_message.dart';
import 'package:notes_app/ui/widgets/widget_button.dart';
import 'package:notes_app/ui/widgets/widget_text_form_field.dart';
import 'package:provider/provider.dart';

final _formKey = GlobalKey<FormState>();
class PageAddNote extends StatefulWidget {
  static const routePage = GlobalVariable.routeaddnote;

  @override
  State<PageAddNote> createState() => _PageAddNoteState();
}

class _PageAddNoteState extends State<PageAddNote> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BodyLogin();
  }
}

class BodyLogin extends StatelessWidget {
  ProviderGeneral? providerGeneral;

  @override
  Widget build(BuildContext context) {
    providerGeneral ??=Provider.of<ProviderGeneral>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Notes"),
      ),
      backgroundColor: AppColor.colorwhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Add Note",style: TextStyle(fontSize: 32),),
                  contTextDescrption(),
                  const SizedBox(height: 3,),
                  buttonEnter(context),
                  //contHelp()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget contTextDescrption() {
    return WidgetTextFormField(
      padding: const EdgeInsets.symmetric(vertical: 10),
      controller: providerGeneral!.controllerDescription,
      labelTitle: "Description",
      keyboardType: TextInputType.text,
      //inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("0-9A-Za-z"))],
      hintText: 'Ej:ialtamirano@ucuenca.edu.ec',
      fontSize: 16,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      colorWhenFocus: true,
      validator: (val) {
        String text = val!.trim();
        if (text.isEmpty) {
          return "Ingrese  un email";
        }
        return null;
      },
    );
  }



  Widget buttonEnter(BuildContext context) {
    return WidgetButton(
      text: "Agregar",
      color: AppColor.colorprimary,
      colorText: AppColor.colorwhite,
      sizeText: 14,
      onTap: () {
        if (_formKey.currentState!.validate()) {
          providerGeneral!.addNote(context);
        } else {
          WidgetAlertMessage(context,"Revise que la información ingresada sea correcta e intente nuevamente.",iconAlert: "error.png",(){
          });
        }
      },
    );
  }
}