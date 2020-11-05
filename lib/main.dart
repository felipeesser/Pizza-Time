import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_time/notifier/ItemNotifier.dart';
import 'package:pizza_time/telas/home_files_rest/Home_Rest.dart';
import 'package:provider/provider.dart';
import 'telas/Login.dart';
import 'package:pizza_time/modelo/Rotas.dart' as router;
import 'package:google_fonts/google_fonts.dart';
import './modelo/tema.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(
        builder: (context) => ItemNotifier(),
      )
    ],
    child: MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getTemaAplicativo(context),
      onGenerateRoute: router.generateRoute,
      initialRoute: "/home",
    );
  }
}