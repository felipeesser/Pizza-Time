import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_time/telas/Info_Item.dart';
import 'dart:io';

class HomeFilter extends StatefulWidget {
  @override
  _HomeFilterState createState() => _HomeFilterState();
}

class _HomeFilterState extends State<HomeFilter> {
  Widget _filtro() {
    return Container(
      height: 200.0,
      width: 200.0,
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              'Doce',
              style: TextStyle(
                color: Color.fromRGBO(204, 41, 0, 1),
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Salgada',
              style: TextStyle(color: Color.fromRGBO(204, 41, 0, 1)),
            ),
          ),
          ListTile(
            title: Text(
              'Vegetariana',
              style: TextStyle(
                color: Color.fromRGBO(204, 41, 0, 1),
              ),
            ),
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 14, bottom: 3),
                child: Icon(Icons.filter_list, size: 25, color: Color.fromRGBO(204, 41, 0, 1))
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text("Filtro", style: TextStyle(color: Color.fromRGBO(89, 89, 89, 1), fontWeight:FontWeight.w100,fontSize: 16),)
            ),
          ],
        ),
      ),
      onPressed: () {setState(() {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Filtro"),
                content: _filtro(),
              );
            });
      });},
      disabledTextColor: Colors.black,
      disabledColor: Colors.white,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
    );
  }
}
