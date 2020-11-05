import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Item{
  String nome;
  String imagem;
  Item.fromMap(Map<String, dynamic> data){
    nome=data['nome'];
    imagem=data['imagem'];
  }
}