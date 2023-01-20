import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes_app/ui/providers/provider_login.dart';
import 'package:notes_app/ui/utils/app_color.dart';
import 'package:notes_app/ui/utils/global_variable.dart';
import 'package:notes_app/ui/widgets/widget_alert_message.dart';
import 'package:notes_app/ui/widgets/widget_button.dart';
import 'package:notes_app/ui/widgets/widget_text_form_field.dart';
import 'package:provider/provider.dart';

final _formKey = GlobalKey<FormState>();
class PageLogin extends StatefulWidget {
  static const routePage = GlobalVariable.routelogin;

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {

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
  ProviderLogin? providerLogin;

  @override
  Widget build(BuildContext context) {
    providerLogin ??=Provider.of<ProviderLogin>(context);
    return Scaffold(
      // appBar: AppBar(),
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
                  Text("Login",style: TextStyle(fontSize: 32),),
                  contTextUser(),
                  contTextPassword(),
                  //contRecoverPassword(context),
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

  Widget contTextUser() {
    return WidgetTextFormField(
      padding: const EdgeInsets.symmetric(vertical: 10),
      controller: providerLogin!.controllerUser,
      labelTitle: "Email",
      keyboardType: TextInputType.emailAddress,
      inputFormatters: [ FilteringTextInputFormatter.deny(RegExp(r'ñ'),replacementString: '')],
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

  Widget contTextPassword() {
    return WidgetTextFormField(
      padding: const EdgeInsets.symmetric(vertical: 10),
      obscureText: providerLogin!.visiblePassword,
      controller: providerLogin!.controllerPassword,
      labelTitle:  "Password",
      keyboardType: TextInputType.visiblePassword,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9A-Za-z]'))],
      colorWhenFocus: true,
      hintText: '********',
      fontSize: 16,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      suffixIcon: Icon(
        providerLogin!.visiblePassword? Icons.remove_red_eye_outlined:Icons.visibility_off_outlined,
        //color: Theme.of(context).primaryColor,
      ),
      onTapSufixIcon: (){
        providerLogin!.visiblePassword= providerLogin!.visiblePassword?false:true;
      },
      validator: (val) {
        String text = val!.trim();
        if (text.isEmpty) {
          return "Ingrese un password";
        }
        return null;
      },
    );
  }


  Widget buttonEnter(BuildContext context) {
    return WidgetButton(
      text: "Ingresar",
      color: AppColor.colorprimary,
      colorText: AppColor.colorwhite,
      sizeText: 14,
      onTap: () {
        if (_formKey.currentState!.validate()) {
          providerLogin!.login(context);
        } else {
           WidgetAlertMessage(context,"Revise que la información ingresada sea correcta e intente nuevamente.",iconAlert: "error.png",(){
           });
        }
      },
    );
  }
}