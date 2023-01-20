import 'package:flutter/material.dart';
import 'package:notes_app/data/repository/api_repository.dart';
import 'package:notes_app/models/model_notes.dart';
import 'package:notes_app/ui/widgets/widget_alert_message.dart';

class ProviderGeneral extends ChangeNotifier {

  TextEditingController _controllerDescription = TextEditingController();
  List<Notes> _listNotes=[];
  List<Notes> _listNot=[];
  Notes _notes= Notes();
  bool _checkComplete=false;


  TextEditingController get controllerDescription => _controllerDescription;

  set controllerDescription(TextEditingController value) {
    _controllerDescription = value;
    notifyListeners();
  }

  List<Notes> get listNotes => _listNotes;

  set listNotes(List<Notes> value) {
    _listNotes = value;
    notifyListeners();
  }


  List<Notes> get listNot => _listNot;

  set listNot(List<Notes> value) {
    _listNot = value;
    notifyListeners();
  }

  Notes get notes => _notes;

  set notes(Notes value) {
    _notes = value;
    notifyListeners();
  }


  bool get checkComplete => _checkComplete;

  set checkComplete(bool value) {
    _checkComplete = value;
    notifyListeners();
  }

  getAllNotes()async{
    listNotes=[];
    listNot=[];
    ApiRepository().getAllNotes( (code, data){
      if(code ==1){
        List<dynamic> list=data;
        list.forEach((element) {
          listNot.add(Notes.fromMap(element));
        });
        listNot.where((element) => element.active==true).toList();
        listNot.forEach((element) {
          if(element.active==true) listNotes.add(element);
        });
        //listNotes=listNot;
        notifyListeners();
      }else{
        listNotes=[];
        print("Message $data");
      }
      notifyListeners();
    });
  }

  addNote(BuildContext context)async{
    ApiRepository().addNote(controllerDescription.text, (code, data){
      if(code==1){
        WidgetAlertMessage(context,"Se agrego correctamente",title: "Información",iconAlert: "checksuccess.png",(){
          getAllNotes();
          Navigator.pop(context);
        });
      }else{
        WidgetAlertMessage(context,"No se agrego",title: "Información",iconAlert: "error.png",(){
        });
      }
    });
  }

  chargeNote(Notes note)async{
    notes=note;
    checkComplete=note.completed!;
    controllerDescription.text=note.description!;
  }


  updateNote(BuildContext context)async{
    ApiRepository().updateNote(controllerDescription.text,checkComplete,notes.id!, (code, data){
      if(code==1){
        WidgetAlertMessage(context,"Se actualizo correctamente ",title: "Información",iconAlert: "checksuccess.png",(){
          getAllNotes();
          Navigator.pop(context);
        });
      }else{
        WidgetAlertMessage(context,"No se agrego",title: "Información",iconAlert: "error.png",(){
        });
      }
    });
  }

  deleteNote(BuildContext context,int idNote)async{
    ApiRepository().deleteNote(idNote, (code, data){
      if(code==1){
        WidgetAlertMessage(context,"Se elimino correctamente ",title: "Información",iconAlert: "checksuccess.png",(){
          getAllNotes();
        });
      }else{
        WidgetAlertMessage(context,"No se agrego",title: "Información",iconAlert: "error.png",(){
        });
      }
    });
  }

}