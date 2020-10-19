import 'package:flutter/material.dart';
import 'dialog_edit_item.dart';
import 'Carrinho.dart';

/// Constrói cada item da lista de pedido do cliente.
///
/// ```dart
/// ListView.separated(
///   itemCount: carrinho.length,
///   itemBuilder: (context, index) {
///     return ListItemPedidoUsuario(item: carrinho.itensPedido[index]);
///   },
///   separatorBuilder: (context, index) => Divider(),
/// );
/// ```
class ListItemPedidoUsuario extends StatefulWidget {
  final ItemPedido item;

  ListItemPedidoUsuario({Key key, @required this.item}) : super(key: key);

  @override
  _ListItemPedidoUsuarioState createState() => _ListItemPedidoUsuarioState();
}

class _ListItemPedidoUsuarioState extends State<ListItemPedidoUsuario> {
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
