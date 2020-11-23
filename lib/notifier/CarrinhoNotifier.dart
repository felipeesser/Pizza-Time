import 'package:flutter/material.dart';

import 'package:pizza_time/modelo/carrinho.dart';
import 'package:pizza_time/modelo/item_carrinho.dart';

class CarrinhoNotifier extends ChangeNotifier {
  Carrinho _carrinhoAtual = Carrinho();
  Carrinho get carrinhoAtual => _carrinhoAtual;

  set carrinhoAtual(Carrinho value) {
    _carrinhoAtual = value;
    notifyListeners();
  }

  void adicionarItem(ItemCarrinho item) {
    _carrinhoAtual.itensCarrinho.add(item);
    notifyListeners();
  }

  void removerItem(ItemCarrinho item) {
    _carrinhoAtual.itensCarrinho.remove(item);
    notifyListeners();
  }

  // Remove todos os itens do carrinho.
  void esvaziarCarrinho() {
    _carrinhoAtual.itensCarrinho.clear();
    notifyListeners();
  }
}
