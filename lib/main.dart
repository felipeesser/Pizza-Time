import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pizza_time/notifier/ItemNotifier.dart';
import 'package:provider/provider.dart';
import 'modelo/Rotas.dart';
import './modelo/tema.dart';
import 'package:pizza_time/notifier/CarrinhoNotifier.dart';
import 'package:pizza_time/notifier/item_carrinho_notifier.dart';
import 'package:pizza_time/notifier/pedido_notifier.dart';
import 'notifier/funcionamentoNotifier.dart';

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
          ChangeNotifierProvider(
            create: (context) => FuncionamentoNotifier(),
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
