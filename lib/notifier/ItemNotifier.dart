import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pizza_time/modelo/Item.dart';
class ItemNotifier extends ChangeNotifier{
  List<Item> _listaItens =[];
  Item _itemAtual;
  UnmodifiableListView<Item> get listaItens=>UnmodifiableListView(_listaItens);
  Item get itemAtual=>_itemAtual;
  set listaItens(List<Item> value) {
    _listaItens = value;
    notifyListeners();
  }
  set itemAtual(Item value) {
    _itemAtual = value;
    notifyListeners();
  }
}