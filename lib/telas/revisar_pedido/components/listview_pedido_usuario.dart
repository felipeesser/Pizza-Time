import 'package:flutter/material.dart';
// import 'listitem_pedido_usuario.dart';
import 'dialog_edit_item.dart';
// TODO - remover as referencias ao carrinho assim que discutirmos como será o backend.
import 'Carrinho.dart';

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
        // return ListItemPedidoUsuario(item: carrinho.itensPedido[index]);
        return _buildListItem(carrinho.itensPedido[index]);
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }

  /// Constrói a representação visual do item da lista de pedido do cliente.
  _buildListItem(ItemPedido item) {
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
      onTap:

          /// Apresenta a caixa de dialogo para edição do item.
          () async {
        await showDialog(
          context: context,
          useSafeArea: true,
          barrierDismissible: false,
          builder: (context) => DialogEditarItem(
            carrinho: carrinho,
            item: item,
          ),
        );
      },
    );
  }
}
