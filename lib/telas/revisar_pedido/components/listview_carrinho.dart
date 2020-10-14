import 'package:flutter/material.dart';
import 'Carrinho.dart';

class ListViewCarrinho extends StatefulWidget {
  @override
  _ListViewCarrinhoState createState() => _ListViewCarrinhoState();
}

class _ListViewCarrinhoState extends State<ListViewCarrinho> {
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
      itemCount: carrinho.itensPedido.length,
      itemBuilder: (context, index) {
        return _buildListItem(context, carrinho.itensPedido[index]);
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }

  Widget _buildListItem(BuildContext context, ItemPedido item) {
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
