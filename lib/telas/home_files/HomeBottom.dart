import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pizza_time/telas/Item.dart';
class HomeBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
        ),
        disabledColor: Colors.white,
        onPressed: null,
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Rua dos Bobos 666',style:TextStyle(color: Color.fromRGBO(204, 41, 0, 1)),)
        )
    );
  }
}
