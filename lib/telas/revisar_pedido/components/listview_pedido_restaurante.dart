import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pizza_time/modelo/item_carrinho.dart';
import 'package:pizza_time/notifier/CarrinhoNotifier.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    _carrinhoNotifier = Provider.of<CarrinhoNotifier>(context);
    return ListView.separated(
      itemCount: _carrinhoNotifier.carrinhoAtual.itensCarrinho.length,
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
        '${item.item.nome}',
        maxLines: 2,
        overflow: TextOverflow.fade,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      leading: Container(
        width: 80,
        child:
            item.item.imagem.runtimeType != String || item.item.imagem.isEmpty
                ? Icon(Icons.image)
                : Image.network(
                    item.item.imagem,
                    fit: BoxFit.cover,
                  ),
      ),
      subtitle: Text(
        'Qtd.: ${item.quantidade}',
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: false,
      ),
      onTap: null,
    );
  }
}
