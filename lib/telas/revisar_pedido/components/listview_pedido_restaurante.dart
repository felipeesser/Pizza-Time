import 'package:flutter/material.dart';
import 'listitem_pedido_restaurante.dart';
// TODO - remover as referencias ao carrinho assim que discutirmos como será o backend.
import 'Carrinho.dart';

/// Apresenta, como lista, os itens do pedido do cliente para a visualização do restaurante.
class ListViewPedidoRestaurante extends StatefulWidget {
  @override
  _ListViewPedidoRestauranteState createState() =>
      _ListViewPedidoRestauranteState();
}

class _ListViewPedidoRestauranteState extends State<ListViewPedidoRestaurante> {
  Carrinho carrinho;

  @override
  void initState() {
    super.initState();
    // REVIEW - usar Provider
    carrinho = carrinhoTEMP;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: carrinho.length,
      itemBuilder: (context, index) {
        return ListItemPedidoRestaurante(item: carrinho.itensPedido[index]);
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }
}
