import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pizza_time/modelo/Item.dart';
import 'package:pizza_time/notifier/ItemNotifier.dart';
getItens(ItemNotifier itemNotifier)async{
  QuerySnapshot snapshot=await Firestore.instance.collection('cardapio').getDocuments();
  List<Item> _itemList=[];
  snapshot.documents.forEach((document){
    Item item=Item.fromMap(document.data);
    _itemList.add(item);
  });
  itemNotifier.listaItens=_itemList;
}