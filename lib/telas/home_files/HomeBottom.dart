import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pizza_time/telas/Info_Item.dart';
class HomeBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
        ),
        color: Colors.white,
        onPressed: (){},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Pedidos:'),
            Icon(Icons.shopping_cart,color: Color.fromRGBO(204, 41, 0, 1),),
          ],
        )
    );
  }
}
