import 'package:flutter/material.dart';
import 'package:pizza_time/telas/Cadastro.dart';
import 'package:pizza_time/telas/finalizar_pedido/finalizar_pedido_route.dart';
import 'package:pizza_time/telas/home_files/Home.dart';
import 'package:pizza_time/telas/Login.dart';
import 'package:pizza_time/telas/home_files_rest/Home_Rest.dart';
import 'package:pizza_time/telas/revisar_pedido/revisar_pedido_restaurante.dart';
import 'package:pizza_time/telas/revisar_pedido/revisar_pedido_usuario.dart';

Route<dynamic> generateRoute(RouteSettings settings){

    switch( settings.name ){
      /*case "/" :
        return MaterialPageRoute(
            builder: (_) => Login()
           // builder: (_) => Home_Rest()
        );*/
      case "/rev_pedido" :
        return MaterialPageRoute(
            builder: (_) => RevisarPedidoUsuario()
        );
      case "/rev_pedido_rest" :
        return MaterialPageRoute(
            builder: (_) => RevisarPedidoRestaurante()
        );
      case "/fin_pedido" :
        return MaterialPageRoute(
            builder: (_) => FinalizarPedido()
        );
      case "/login" :
        return MaterialPageRoute(
            builder: (_) => Login()
        );
      case "/cadastro" :
        return MaterialPageRoute(
            builder: (_) => Cadastro()
        );
      case "/home" :
        return MaterialPageRoute(
            builder: (_) => Home()
        );
      case "/home_rest" :
        return MaterialPageRoute(
            builder: (_) => Home_Rest()
        );
      default:
        return MaterialPageRoute(
            builder: (_) => Home()
        );
    }

  }

