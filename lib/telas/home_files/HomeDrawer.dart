import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pizza_time/telas/Info_Item.dart';
import 'dart:io';
import '../Login.dart';
class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          ListTile(title: Text('Perfil',style: TextStyle(color: Colors.black),),
            leading: Icon(Icons.perm_identity,color: Color.fromRGBO(204, 41, 0, 1),),),
          ListTile(title: Text('Carrinho',style: TextStyle(color: Colors.black),),
            leading: Icon(Icons.shopping_cart,color: Color.fromRGBO(204, 41, 0, 1),),
            subtitle: Text('Pedidos',style: TextStyle(color: Colors.black),),isThreeLine: true,),
          ListTile(title: Text('Chat',style: TextStyle(color: Colors.black),),
              leading: Icon(Icons.chat,color: Color.fromRGBO(204, 41, 0, 1),)),
        ],
      ),
    );
  }
}
