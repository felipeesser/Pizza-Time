import 'package:flutter/material.dart';
import 'package:pizza_time/telas/Detalhes.dart';
import 'package:pizza_time/telas/home_files/home_files_components/Pedidos_Feitos_Card.dart';
import 'package:pizza_time/telas/home_files_rest/Home_Rest_Ped.dart';

class Pedidos_Feitos extends StatefulWidget {
  static final nomeTela = "/pedidos_feitos";

  @override
  _Pedidos_FeitosState createState() => _Pedidos_FeitosState();
}

class _Pedidos_FeitosState extends State<Pedidos_Feitos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedidos feitos"),
      ),
      body: ListView(
        children: <Widget>[
          GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(Detalhes.nomeTela);
              },
              child: Pedidos_Feitos_Card(
                  "Alberto",
                  "cartao",
                  "Rua dos bobos 666",
                  ["pizza doce", "pizza de carne seca"],
                  ["1", "2"])),
          GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(Detalhes.nomeTela);
              },
              child: Pedidos_Feitos_Card(
                  "Roberto",
                  "dinheiro",
                  "Rua dos bobos 6666",
                  ["pizza doce", "pizza de carne seca"],
                  ["2", "2"])),
          GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(Detalhes.nomeTela);
              },
              child: Pedidos_Feitos_Card(
                  "Marreco",
                  "cartao",
                  "Rua dos bobos 66666",
                  ["pizza doce", "pizza de carne seca"],
                  ["1", "3"])),
        ],
      ),
    );
  }
}
