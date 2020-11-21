import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:pizza_time/modelo/Item.dart';
import 'package:pizza_time/modelo/carrinho.dart';
import 'package:pizza_time/modelo/item_carrinho.dart';
class CarrinhoNotifier extends ChangeNotifier{
  //List<ItemCarrinho> _listaItens =[];
  Carrinho _carrinhoAtual=Carrinho();
  //UnmodifiableListView<Item> get listaItens=>UnmodifiableListView(_listaItens);
  Carrinho get carrinhoAtual=>_carrinhoAtual;
//  set listaItens(List<Item> value) {
//    _listaItens = value;
//    notifyListeners();
//  }
  set carrinhoAtual(Carrinho value) {
    _carrinhoAtual = value;
    notifyListeners();
  }
  adicionarItem(ItemCarrinho item){
    _carrinhoAtual.itensCarrinho.add(item);
    notifyListeners();
  }
  removerItem(ItemCarrinho item){
    _carrinhoAtual.itensCarrinho.remove(item);
    notifyListeners();
  }
}