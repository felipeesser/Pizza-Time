import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Abertura extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horário de Funcionamento'),
        centerTitle: true,
        backgroundColor: Color(0xFFbd1918),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.only(top: 40),
            child: Text(
              'Segunda à Sexta: 9 às 20h',
              style: TextStyle(
                fontSize: 20.0
              ),
            ),
          ),
          Container(
            child: Text(
              'Sábado e Domingo: 13 às 22h',
              style: TextStyle(
                fontSize: 20.0
              ),
            ),
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.only(top: 30),
          ),
          Container(
            child: Text(
              'Editar Horário',
              style: TextStyle(
                fontSize: 30
              ),
            ),
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.only(top: 50),
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.only(left:10, top: 30),
                child: Text(
                  'Hoje: ',
                  style: TextStyle(
                    fontSize: 25
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Início:',
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  '9h',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFbd1918),
                    borderRadius: BorderRadius.circular(25)
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 80),
                child: Text(
                  'Fim:',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  '20h',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFbd1918),
                    borderRadius: BorderRadius.circular(25)
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                  margin: EdgeInsets.only(top: 40),
                child: Text(
                  'Fim de semana:',
                  style: TextStyle(
                    fontSize: 20.0
                  ),
                )
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Início:',
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  '13h',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                decoration: BoxDecoration(
                    color: Color(0xFFbd1918),
                    borderRadius: BorderRadius.circular(25)
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 80),
                child: Text(
                  'Fim:',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  '22h',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                decoration: BoxDecoration(
                    color: Color(0xFFbd1918),
                    borderRadius: BorderRadius.circular(25)
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
