import 'package:flutter/material.dart';
import 'package:notes_app/data/repository/local_repository.dart';
import 'package:notes_app/ui/page/page_login/page_login.dart';
import 'package:notes_app/ui/page/page_notes/page_add_note.dart';
import 'package:notes_app/ui/page/page_notes/page_note.dart';
import 'package:notes_app/ui/page/page_notes/page_update_note.dart';
import 'package:notes_app/ui/providers/provider_general.dart';
import 'package:notes_app/ui/providers/provider_login.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  LocalRepository().getUser().then((value){
    print('+++++++++ $value');
    if(value!=null){
      runApp( MyApp(PageNotes.routePage));
    }else{
      runApp( MyApp(PageLogin.routePage));
    }
  });

}

class MyApp extends StatelessWidget {
  final String route;
  const MyApp(this.route,{super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderLogin()),
        ChangeNotifierProvider(create: (_) => ProviderGeneral()),
      ],
      child: MaterialApp(
        title: 'Taximetro ',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        routes:<String, WidgetBuilder>{
          PageLogin.routePage: (_) => PageLogin(),
          PageNotes.routePage: (_) => PageNotes(),
          PageAddNote.routePage: (_) => PageAddNote(),
          PageUpdateNote.routePage: (_) => PageUpdateNote(),
        },
        initialRoute: route,
        //home: ,
      ),
    );
  }
}