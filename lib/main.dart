import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'telas/Login.dart';
import 'package:pizza_time/modelo/Rotas.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Login(),
        initialRoute: "/",
        onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}