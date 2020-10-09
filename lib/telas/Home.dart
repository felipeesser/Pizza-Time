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
      appBar: AppBar(
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
                    child: ListView(
                      children: snapshot.data.documents.map<Widget>((DocumentSnapshot doc) {
                        return ListTile(
                          leading: Icon(Icons.people,size: 52,),
                          title: Text(doc.data['nome']),
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
