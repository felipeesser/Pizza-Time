import 'package:flutter/material.dart';
import 'listview_pedido_restaurante.dart';

/// Posiciona os widgets da aba produtos do pedido.
class TabProdutos extends StatelessWidget {
  static final nomeAba = 'Produtos';

  @override
  Widget build(BuildContext context) {
    return ListViewPedidoRestaurante();
  }
}
