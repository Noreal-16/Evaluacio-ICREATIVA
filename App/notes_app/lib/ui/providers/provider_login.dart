import 'package:flutter/material.dart';
import 'package:notes_app/data/repository/api_repository.dart';
import 'package:notes_app/data/repository/local_repository.dart';
import 'package:notes_app/data/responses/response_login.dart';
import 'package:notes_app/ui/page/page_notes/page_note.dart';

class ProviderLogin extends ChangeNotifier {

  TextEditingController _controllerUser = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  ResponseLogin _responseLogin= ResponseLogin();
  bool _visiblePassword = true;





  ResponseLogin get responseLogin => _responseLogin;

  set responseLogin(ResponseLogin value) {
    _responseLogin = value;
    notifyListeners();
  }


  TextEditingController get controllerUser => _controllerUser;

  set controllerUser(TextEditingController value) {
    _controllerUser = value;
    notifyListeners();
  }

  TextEditingController get controllerPassword => _controllerPassword;

  set controllerPassword(TextEditingController value) {
    _controllerPassword = value;
    notifyListeners();
  }


  bool get visiblePassword => _visiblePassword;

  set visiblePassword(bool value) {
    _visiblePassword = value;
    notifyListeners();
  }

  login(BuildContext context)async{
    ApiRepository().login(controllerUser.text, controllerPassword.text, (code, data){
      if(code ==1){
        responseLogin=data;
        LocalRepository().saveUser(responseLogin.user!).then((value){
          LocalRepository().saveToken(responseLogin.token!).then((value){
            print('+++++++++++++ $responseLogin');
            //Navigator.of(context).pushNamedAndRemoveUntil(PageNote.routePage, (Route<dynamic> route) => false);
            Navigator.pushNamed(context, PageNotes.routePage);
          });
        });
      }else{
        print("Message $data");
      }
    });
  }


}