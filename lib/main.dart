import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_time/notifier/ItemNotifier.dart';
import 'package:pizza_time/telas/home_files_rest/Home_Rest.dart';
import 'package:provider/provider.dart';
import 'telas/Login.dart';
//import 'package:pizza_time/modelo/Rotas.dart' as router;
import 'modelo/Rotas.dart';
import 'package:google_fonts/google_fonts.dart';
import './modelo/tema.dart';
import 'package:pizza_time/notifier/CarrinhoNotifier.dart';
import 'package:pizza_time/notifier/item_carrinho_notifier.dart';
import 'package:pizza_time/notifier/pedido_notifier.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ItemNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => CarrinhoNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => ItemCarrinhoNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => PedidoNotifier(),
      ),
    ],
    child: MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      theme: getTemaAplicativo(context),
      //onGenerateRoute: router.generateRoute,
      initialRoute: appInitialRoute,
      routes: appRoutes,
    );
  }
}