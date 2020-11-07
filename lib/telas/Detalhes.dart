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
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 35.0),
                    child: Text(
                      'Endereço da Entrega',
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      'Valor: 20,00\u0024',
                      style: TextStyle(
                        fontSize: 20.0
                      ),
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
          Container(
            margin: EdgeInsets.all(40),
            child: Text(
              'Status do Pedido:',
              style: TextStyle(
                fontSize: 22.0
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(35),
            child: Text(
              'Preparando...',
              style: TextStyle(
                fontSize: 18
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(top:120.0, left: 20, right: 20),
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Contato com o restaurante',
              style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Color(0xFFbd1918),
            ),
          )
        ]
      )
    );
  }
}



