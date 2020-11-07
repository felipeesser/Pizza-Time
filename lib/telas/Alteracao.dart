import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pizza_time/telas/revisar_pedido/components/tab_detalhes.dart';

class Alteracao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFFbd1918),
        centerTitle: true,
        title: Text('Alteração de Cadastro'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              'Nome atual',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white
              ),
            ),
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.only(top:35, bottom: 30, left: 50, right: 50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Color(0xFFdd6311),
            ),
          ),
          Container(
            height: 50,
            width: 300,
            child: TextFormField(
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Novo nome',
                hintStyle: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white
                ),
                filled: true,
                fillColor: Color(0xFFdd6311),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              'Senha atual',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white
              ),
            ),
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.only(top: 25,bottom: 30, left: 50, right: 50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Color(0xFFdd6311),
            ),
          ),
          Container(
            height: 50,
            width: 300,
            child: TextFormField(
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Nova senha',
                hintStyle: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white
                ),
                filled: true,
                fillColor: Color(0xFFdd6311),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              'Endereço',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white
              ),
            ),
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.only(top: 25,bottom: 30, left: 50, right: 50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Color(0xFFdd6311),
            ),
          ),
          Container(
            height: 50,
            width: 300,
            child: TextFormField(
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Novo Endereço',
                hintStyle: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white
                ),
                filled: true,
                fillColor: Color(0xFFdd6311),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: SizedBox(
              width: 200,
              height: 100,
              child: RaisedButton(
                child: Text(
                  'Salvar',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white
                  ),
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}

