import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'telas/Login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          '/': (context) => Login(),
          '/home': (context)=>MyHomePage(title: 'Flutter Demo Home Page'),
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: StreamBuilder(
            stream: Firestore.instance.collection('usuarios').snapshots(),
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
                          title: Text(doc.data['nome']+" - "+doc.data['idade'].toString()+" anos"),
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