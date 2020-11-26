import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pizza_time/modelo/item_carrinho.dart';
import 'package:pizza_time/notifier/CarrinhoNotifier.dart';
import 'package:pizza_time/notifier/item_carrinho_notifier.dart';

/// Apresenta, como lista, os itens do pedido do cliente para a visualização do restaurante.
class ListViewPedidoRestaurante extends StatefulWidget {
  @override
  _ListViewPedidoRestauranteState createState() =>
      _ListViewPedidoRestauranteState();
}

class _ListViewPedidoRestauranteState extends State<ListViewPedidoRestaurante> {
  CarrinhoNotifier _carrinhoNotifier;

  @override
  void initState() {
    super.initState();
    _carrinhoNotifier = Provider.of<CarrinhoNotifier>(context);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _carrinhoNotifier.carrinhoAtual.length,
      itemBuilder: (context, index) {
        return _buildListItem(
            _carrinhoNotifier.carrinhoAtual.itensCarrinho[index]);
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }

  /// Constrói a representação visual do item da lista de pedido do cliente.
  _buildListItem(ItemCarrinho item) {
    return ListTile(
      dense: true,
      title: Text(
        item.item.nome,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      leading: Icon(Icons.image),
      subtitle: Text(
        'Valor unitário: R\$ ${item.item.preco}'
            '\n'
            'Quantidade: ${item.quantidade}',
        maxLines: 2,
      ),
      trailing: Text(
        'R\$ ${item.total.toStringAsFixed(2)}',
        textAlign: TextAlign.center,
      ),
      onTap: null,
    );
  }
}