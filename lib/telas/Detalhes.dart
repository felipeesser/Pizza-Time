import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Detalhes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Pedido'),
        centerTitle: true,
        backgroundColor: Color(0xFFbd1918),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Endereço da Entrega',
                    style: TextStyle(
                      fontSize: 20.0
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Valor: 20,00\u0024',
                    style: TextStyle(
                      fontSize: 20.0
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 150.0,
            thickness: 1.0,
            color: Color(0xFF000000),
          ),
          Text(
            'Status do Pedido:',
            style: TextStyle(
              fontSize: 22.0
            ),
          ),
          Text(
            'Preparando...',
            style: TextStyle(
              fontSize: 18
            ),
          ),
          FlatButton(
            onPressed: (){},
            child: Text(
              'Contato com o restaurante',
              style: TextStyle(
              fontSize: 20.0,
              ),
            ),
          )
        ]
      )
    );
  }
}



