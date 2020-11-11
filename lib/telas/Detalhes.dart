import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Detalhes extends StatelessWidget {
  static final nomeTela = "/detalhes";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Pedido'),
        centerTitle: true,
        backgroundColor: Color(0xFFbd1918),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Endereço da Entrega',
                style: TextStyle(
                  fontSize: 20.0
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Descrição do pedido: ',
                style: TextStyle(
                  fontSize: 20.0
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Valor: 20,00\u0024',
                style: TextStyle(
                  fontSize: 20.0
                ),
              ),
            ),
          ),
          Divider(
            height: 150.0,
            thickness: 1.0,
            color: Color(0xFF000000),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Status do Pedido:',
              style: TextStyle(
                fontSize: 22.0
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Preparando...',
              style: TextStyle(
                fontSize: 18
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FlatButton(
              onPressed: (){},
              child: Text(
                'Contato com o restaurante',
                style: TextStyle(
                fontSize: 20.0,
                ),
              ),
            ),
          )
        ]
      )
    );
  }
}



