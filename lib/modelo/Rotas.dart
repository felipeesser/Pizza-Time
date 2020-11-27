import 'package:flutter/material.dart';
import 'package:pizza_time/telas/home_files/Info_Item.dart';
import 'package:pizza_time/telas/home_files/Pedidos_Feitos.dart';
import 'package:pizza_time/telas/home_files_rest/Abertura.dart';
import 'package:pizza_time/telas/home_files/Alteracao.dart';
import 'package:pizza_time/telas/Cadastro.dart';
import 'package:pizza_time/telas/home_files/Detalhes.dart';
import 'package:pizza_time/telas/finalizar_pedido/finalizar_pedido_route.dart';
import 'package:pizza_time/telas/home_files/Home.dart';
import 'package:pizza_time/telas/Login.dart';
import 'package:pizza_time/telas/home_files_rest/Home_Rest.dart';
import 'package:pizza_time/telas/novo_endereco/novo_endereco.dart';
import 'package:pizza_time/telas/revisar_pedido/revisar_pedido_restaurante.dart';
import 'package:pizza_time/telas/revisar_pedido/revisar_pedido_usuario.dart';
import 'package:pizza_time/telas/AbaConversas.dart';
import 'package:pizza_time/telas/Mensagens.dart';

import '../telas/home_files_rest/Adicionar.dart';

final appInitialRoute = Login.nomeTela;
final appRoutes = {
  Home.nomeTela: (context) => Home(),
  FinalizarPedido.nomeTela: (context) => FinalizarPedido(),
  Abertura.nomeTela: (context) => Abertura(),
  Home_Rest.nomeTela: (context) => Home_Rest(),
  NovoEndereco.nomeTela: (context) => NovoEndereco(),
  RevisarPedidoRestaurante.nomeTela: (_) => RevisarPedidoRestaurante(),
  RevisarPedidoUsuario.nomeTela: (_) => RevisarPedidoUsuario(),
  Alteracao.nomeTela: (_) => Alteracao(),
  Cadastro.nomeTela: (_) => Cadastro(),
  Detalhes.nomeTela: (_) => Detalhes(),
  Info_Item.nomeTela: (_) => Info_Item(),
  Login.nomeTela: (_) => Login(),
  Pedidos_Feitos.nomeTela: (_) => Pedidos_Feitos(),
  Mensagens.nomeTela: (_) => Mensagens(),
  AbaConversas.nomeTela: (_) => AbaConversas(),
};

// Route<dynamic> generateRoute(RouteSettings settings){
//
//     switch( settings.name ){
//       /*case "/" :
//         return MaterialPageRoute(
//             builder: (_) => Login()
//            // builder: (_) => Home_Rest()
//         );*/
//       case "/adicionar" :
//         return MaterialPageRoute(
//             builder: (_) => Adicionar()
//         );
//       case "/rev_pedido" :
//         return MaterialPageRoute(
//             builder: (_) => RevisarPedidoUsuario()
//         );
//       case "/rev_pedido_rest" :
//         return MaterialPageRoute(
//             builder: (_) => RevisarPedidoRestaurante()
//         );
//       case "/fin_pedido" :
//         return MaterialPageRoute(
//             builder: (_) => FinalizarPedido()
//         );
//       case "/login" :
//         return MaterialPageRoute(
//             builder: (_) => Login()
//         );
//       case "/cadastro" :
//         return MaterialPageRoute(
//             builder: (_) => Cadastro()
//         );
//       case "/home" :
//         return MaterialPageRoute(
//             builder: (_) => Home()
//         );
//       case "/home_rest" :
//         return MaterialPageRoute(
//             builder: (_) => Home_Rest()
//         );
//       case "/alteracao" :
//         return MaterialPageRoute(
//             builder: (_) => Alteracao()
//         );
//       case "/detalhes" :
//         return MaterialPageRoute(
//             builder: (_) => Detalhes()
//         );
//       case "/abertura" :
//         return MaterialPageRoute(
//             builder: (_) => Abertura()
//         );
//       default:
//         return MaterialPageRoute(
//             builder: (_) => Home()
//         );
//     }
//
//   }
