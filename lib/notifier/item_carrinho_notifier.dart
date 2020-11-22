import 'package:flutter/material.dart';

import 'package:pizza_time/modelo/item_carrinho.dart';

/// Notifica os consumidores dessa classe sobre mudanças realizadas.
///
/// Dispara notificações quando o objeto dessa classe sofrer mudanças.
class ItemCarrinhoNotifier extends ChangeNotifier {
  ItemCarrinho _itemAtual;

  get itemAtual => _itemAtual;

  set itemAtual(ItemCarrinho item) {
    _itemAtual = item;
    notifyListeners();
  }

  String get nomeItemAtual => _itemAtual.item.nome;

  String get valorUnitarioItemAtual => _itemAtual.item.preco;

  String get urlImagemItemAtual => _itemAtual.item.imagem;

  double get valorTotalItemAtual => _itemAtual.total;

  int get quantidadeItemAtual => _itemAtual.quantidade;

  set quantidadeItemAtual(int quantidade) {
    _itemAtual.quantidade = quantidade;
    notifyListeners();
  }
}
