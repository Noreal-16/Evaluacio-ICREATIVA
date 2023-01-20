import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:notes_app/models/model_notes.dart';
import 'package:notes_app/ui/page/page_notes/page_add_note.dart';
import 'package:notes_app/ui/page/page_notes/page_update_note.dart';
import 'package:notes_app/ui/providers/provider_general.dart';
import 'package:notes_app/ui/utils/app_color.dart';
import 'package:notes_app/ui/utils/global_variable.dart';
import 'package:notes_app/ui/widgets/widget_alert_message.dart';
import 'package:notes_app/ui/widgets/widget_progress_circular.dart';
import 'package:provider/provider.dart';

class PageNotes extends StatefulWidget {
  static const routePage = GlobalVariable.routenote;

  @override
  State<PageNotes> createState() => _PageNotesState();
}

class _PageNotesState extends State<PageNotes> {

  ProviderGeneral? providerGeneral;
  @override
  void initState() {
    super.initState();
    providerGeneral =Provider.of<ProviderGeneral>(context,listen: false);
    SchedulerBinding.instance.addPostFrameCallback((_) {
     providerGeneral!.getAllNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BodyNotes();
  }
}

class BodyNotes extends StatelessWidget {

  ProviderGeneral? providerGeneral;


  @override
  Widget build(BuildContext context) {
    providerGeneral ??=Provider.of<ProviderGeneral>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        actions: [
          IconButton(onPressed: (){
            providerGeneral!.controllerDescription.text="";
            Navigator.pushNamed(context, PageAddNote.routePage);
          }, icon: Icon(Icons.add))
        ],
      ),
      backgroundColor: AppColor.colorbackground,
      body: SafeArea(
        child: Stack(children: [
          Container(
            margin: const EdgeInsets.only(left: 20,top: 20,right: 20, bottom: 50),
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 if(providerGeneral!.listNotes.isNotEmpty)...[
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: providerGeneral!.listNotes.length,
                        itemBuilder: (context, index) {
                          return itemNotes(providerGeneral!.listNotes[index],context);
                        }),
                  ]else...[
                    const Center(child: Text("Sin datos de notas"))
                  ]
                ],
              ),
            ),
          ),

        ]),
      ),
    );
  }

  Widget itemNotes(Notes notes, BuildContext context){
    return GestureDetector(
      onTap: (){
        providerGeneral!.chargeNote(notes);
        Navigator.pushNamed(context, PageUpdateNote.routePage).then((value){
          if(value as bool){
            providerGeneral!.getAllNotes();
          }
        });
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
            ),
          ],
          color: AppColor.colorwhite,
          borderRadius: BorderRadius.all(Radius.circular(10),
          ),
        ),
        child: Dismissible(
          key: ValueKey("${notes.id}${DateTime.now().microsecondsSinceEpoch}"),
          background: const SlideLeftBackground(),
          direction: DismissDirection.endToStart,
          confirmDismiss: (direction)async{
            final bool res = await WidgetAlertMessage(context, "¿Estás seguro que deseas eliminar la nota?", () {
              providerGeneral!.deleteNote(context, notes.id!);
            }, iconAlert: "error.png",textAccept: "Eliminar",activeCancel: true );
            return res;
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${notes.description}")
            ],
          ),
        ),
      ),
    );
  }
}
class SlideLeftBackground extends StatelessWidget {
  final String text;

  const SlideLeftBackground({Key? key, this.text = "Eliminar"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
              size: 30,
            ),
            Text(
              " $text",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}