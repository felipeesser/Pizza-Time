import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pizza_time/modelo/Item.dart';
class ItemNotifier extends ChangeNotifier{
  List<Item> _listaItens =[];
  Item _itemAtual;
  int _filtroatual;
  String _palavraAtual;

  String get palavraAtual => _palavraAtual;

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
  set filtroAtual(int i) {
    _filtroatual = i;
    notifyListeners();
  }
  set palavraAtual(String a) {
    _palavraAtual = a;
    notifyListeners();
  }
  List<Item> listaFiltrada(){
    switch (_filtroatual){
      case 0:
        return _listaItens.where((element) => element.tipo=='salgada').toList().where((element) => element.nome.contains(_palavraAtual)).toList();
        break;
      case 1:
        return _listaItens.where((element) => element.tipo=='doce').toList().where((element) => element.nome.contains(_palavraAtual)).toList();
        break;
      case 2:
        return _listaItens.where((element) => element.tipo=='vegetariana').toList().where((element) => element.nome.contains(_palavraAtual)).toList();
        break;
      case 3:
        return _listaItens.where((element) => element.nome.contains(_palavraAtual)).toList();
        break;
      default:
        return _listaItens;
    }
  }
}