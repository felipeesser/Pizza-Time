import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'Login.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromRGBO(204, 41, 0, 1),
      drawer: Drawer(
        child: Container(
            color: Color.fromRGBO(204, 41, 0, 1),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(204, 41, 0, 1),
      ),
      body: Center(
          child: StreamBuilder(
            stream: Firestore.instance.collection('cardapio').snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if (snapshot.hasError){
                return Text('Error: ${snapshot.error}');
              }
              switch (snapshot.connectionState){
                case ConnectionState.waiting:
                  return LinearProgressIndicator();
                  break;
                default:
                  return Center(
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: snapshot.data.documents.map<Widget>((DocumentSnapshot doc) {
                        return Card(
                          child: Center(
                            child: Text(doc.data['nome']),
                          ),
                        );
                      }).toList(),

                    ),
                  );
              }
            },
          )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
