import 'package:flutter/material.dart';
import 'Carrinho.dart';

/// Constrói cada item da lista de pedido do cliente para a visualização do restaurante.
class ListItemPedidoRestaurante extends StatefulWidget {
  final ItemPedido item;

  ListItemPedidoRestaurante({Key key, @required this.item}) : super(key: key);

  @override
  _ListItemPedidoRestauranteState createState() =>
      _ListItemPedidoRestauranteState();
}

class _ListItemPedidoRestauranteState extends State<ListItemPedidoRestaurante> {
  Carrinho carrinho;
  ItemPedido item;

  @override
  void initState() {
    super.initState();
    carrinho = carrinhoTEMP;
    item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(
        item.nome,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      leading: Icon(Icons.image),
      subtitle: Text(
        'Valor unitário: ${Carrinho.moeda} ${item.valor.toStringAsFixed(2).replaceAll('.', ',')}'
        '\n'
        'Quantidade: ${item.quantidade}',
        maxLines: 2,
      ),
      trailing: Text(
        '${Carrinho.moeda} ${item.subtotal.toStringAsFixed(2)}',
        textAlign: TextAlign.center,
      ),
      onTap: () {},
    );
  }
}
