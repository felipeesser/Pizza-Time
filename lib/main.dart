import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_time/notifier/ItemNotifier.dart';
import 'package:pizza_time/telas/home_files_rest/Home_Rest.dart';
import 'package:provider/provider.dart';
import 'telas/Login.dart';
import 'package:pizza_time/modelo/Rotas.dart' as router;
import 'package:google_fonts/google_fonts.dart';
void main() => runApp(MultiProvider(
    providers: [ChangeNotifierProvider(
      builder: (context)=>ItemNotifier(),
    )],
    child: MyApp()
));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          textTheme:  GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
          accentColor: Color.fromRGBO(204, 41, 0, 1),
          appBarTheme: AppBarTheme(color: Color.fromRGBO(204, 41, 0, 1) ),
        ),
        onGenerateRoute: router.generateRoute,
        initialRoute: "/home",
    );
  }
}