import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pizza_time/modelo/item_carrinho.dart';
import 'package:pizza_time/notifier/CarrinhoNotifier.dart';
import 'package:pizza_time/notifier/item_carrinho_notifier.dart';

import './dialog_edit_item.dart';

/// Apresenta, como lista, os itens do pedido do cliente.
///
/// ```dart
/// ...
/// child: ListViewPedidoUsuario(),
/// ...
/// ```
class ListViewPedidoUsuario extends StatefulWidget {
  @override
  _ListViewPedidoUsuarioState createState() => _ListViewPedidoUsuarioState();
}

class _ListViewPedidoUsuarioState extends State<ListViewPedidoUsuario> {
  CarrinhoNotifier _carrinhoNotifier;
  ItemCarrinhoNotifier _itemCarrinhoNotifier;

  @override
  Widget build(BuildContext context) {
    _carrinhoNotifier = Provider.of<CarrinhoNotifier>(context);
    _itemCarrinhoNotifier = Provider.of<ItemCarrinhoNotifier>(context);
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
        item.item.nome,
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.fade,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      leading: item.item.imagem.runtimeType != String || item.item.imagem.isEmpty
          ? Icon(Icons.image)
          : Image.network(
              item.item.imagem,
              fit: BoxFit.fitWidth,
          ),
      subtitle: Text(
        'Valor unitário: R\$ ${double.parse(item.item.preco).toStringAsFixed(2)}'
            '\n'
            'Quantidade: ${item.quantidade}',
        maxLines: 2,
      ),
      trailing: Text(
        'R\$ ${item.total.toStringAsFixed(2)}',
        textAlign: TextAlign.center,
      ),
      onTap: () async {
        _itemCarrinhoNotifier.itemAtual = item;
        await showDialog(
          context: context,
          useSafeArea: true,
          barrierDismissible: false,
          builder: (context) => DialogEditarItem(),
        );
      },
    );
  }
}