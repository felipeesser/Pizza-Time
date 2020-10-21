import 'package:flutter/material.dart';
// TODO - remover as referencias ao carrinho assim que discutirmos como será o backend.
import 'Carrinho.dart';

/// Edita um item dentro do pedido.
///
/// Modifica a quantidade, ou remove da lista de pedido.
class DialogEditarItem extends StatefulWidget {
  final ItemPedido item;
  final Carrinho carrinho;

  /// Contrói o editor para [item] dentro do [carrinho].
  DialogEditarItem({@required this.carrinho, @required this.item});

  @override
  _DialogEditarItemState createState() => _DialogEditarItemState();
}

class _DialogEditarItemState extends State<DialogEditarItem> {
  // referencia para widget.param.item
  ItemPedido item;
  // referencia para widget.param.carrinho
  Carrinho carrinho;

  @override
  void initState() {
    super.initState();
    item = widget.item;
    carrinho = widget.carrinho;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Text(
            '${item.nome}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            color: Colors.teal[200],
          ),
        ),
        // Image.network(src, fit: BoxFit.fitWidth,)
        Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Text(
            'Valor unitário: ${Carrinho.moeda} ${item.valor.toStringAsFixed(2)}',
            maxLines: 1,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.center,
            softWrap: false,
          ),
        ),
        _buildEditorQuantidade(context, item),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Text(
            'Subtotal: ${Carrinho.moeda} ${item.subtotal.toStringAsFixed(2)}',
            maxLines: 1,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.center,
            softWrap: false,
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.start,
          children: [
            RaisedButton(
              child: Text(
                'ok'.toUpperCase(),
              ),
              onPressed: () {},
            ),
            FlatButton(
              child: Text(
                'cancelar'.toUpperCase(),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: 1,
            ),
            // deletar item
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.delete_forever),
                onPressed: () {},
              ),
            ),
          ],
        )
      ],
    );
  }

  // Contrói a barra de edição da quantidade do item.
  Widget _buildEditorQuantidade(BuildContext context, ItemPedido item) {
    return Table(
      columnWidths: {1: FlexColumnWidth(0.5)},
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    item.quantidade--;
                  });
                },
              ),
            ),
            Text(
              '${item.quantidade}',
              textAlign: TextAlign.center,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    item.quantidade++;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
