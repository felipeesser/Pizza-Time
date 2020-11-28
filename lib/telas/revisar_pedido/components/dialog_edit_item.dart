import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:pizza_time/notifier/CarrinhoNotifier.dart';
import 'package:pizza_time/notifier/item_carrinho_notifier.dart';

/// Edita um item dentro do pedido.
///
/// Modifica a quantidade, ou remove da lista de pedido.
class DialogEditarItem extends StatefulWidget {
  /// Contrói o editor de entradas do carrinho.
  ///
  /// Usa Notifiers para recber um objeto do tipo [Carrinho] e [ItemCarrinho].
  DialogEditarItem();

  @override
  _DialogEditarItemState createState() => _DialogEditarItemState();
}

class _DialogEditarItemState extends State<DialogEditarItem> {
  CarrinhoNotifier _carrinhoNotifier;
  ItemCarrinhoNotifier _itemCarrinhoNotifier;
  int _quantidadeAntiga;
  int _quantidadeNova;

  @override
  Widget build(BuildContext context) {
    _carrinhoNotifier = Provider.of<CarrinhoNotifier>(context);
    _itemCarrinhoNotifier = Provider.of<ItemCarrinhoNotifier>(context);
    _quantidadeAntiga ??= _itemCarrinhoNotifier.quantidadeItemAtual;
    _quantidadeNova ??= _itemCarrinhoNotifier.quantidadeItemAtual;

    return SimpleDialog(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 12, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '${_itemCarrinhoNotifier.nomeItemAtual}',
                  maxLines: 1,
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                ),
              ),
              IconButton(
                constraints: BoxConstraints.tightFor(),
                icon: Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                ),
                onPressed: _acaoBotaoRemover,
              ),
            ],
          ),
        ),
        AspectRatio(
          aspectRatio: 16 / 9,
          child:
              _itemCarrinhoNotifier.urlImagemItemAtual.runtimeType != String ||
                      _itemCarrinhoNotifier.urlImagemItemAtual.isEmpty
                  ? Icon(Icons.image)
                  : Image.network(
                      _itemCarrinhoNotifier.urlImagemItemAtual,
                      fit: BoxFit.fitWidth,
                    ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Text(
            'Valor unitário: R\$ ${double.parse(_itemCarrinhoNotifier.valorUnitarioItemAtual).toStringAsFixed(2)}',
            maxLines: 1,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.center,
            softWrap: false,
          ),
        ),
        SizedBox(height: 8),
        _buildEditorQuantidade(context),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Text(
            'Subtotal: R\$ ${_itemCarrinhoNotifier.valorTotalItemAtual.toStringAsFixed(2)}',
            maxLines: 1,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.center,
            softWrap: false,
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'ok'.toUpperCase(),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              onPressed: _acaoBotaoConfirmar,
            ),
            FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'cancelar'.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(color: Colors.black),
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(32),
              ),
              onPressed: _acaoBotaoCancelar,
            ),
          ],
        ),
      ],
    );
  }

  /// Contrói a barra de edição da quantidade do item.
  Widget _buildEditorQuantidade(BuildContext context) {
    return Table(
      columnWidths: {1: FlexColumnWidth(0.4)},
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
                padding: EdgeInsets.zero,
                shape: CircleBorder(),
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _quantidadeNova--;
                  });
                },
              ),
            ),
            Text(
              '$_quantidadeNova',
              textAlign: TextAlign.center,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: FlatButton(
                padding: EdgeInsets.zero,
                shape: CircleBorder(),
                color: Colors.green,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _quantidadeNova++;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  _acaoBotaoRemover() {
    _carrinhoNotifier.removerItem(_itemCarrinhoNotifier.itemAtual);
    Navigator.pop(context);
  }

  void _acaoBotaoConfirmar() {
    if (_quantidadeNova == 0) {
      _carrinhoNotifier.removerItem(_itemCarrinhoNotifier.itemAtual);
    } else if (_quantidadeNova != _itemCarrinhoNotifier.quantidadeItemAtual) {
      _itemCarrinhoNotifier.quantidadeItemAtual = _quantidadeNova;
    }
    Navigator.pop(context);
  }

  void _acaoBotaoCancelar() {
    _itemCarrinhoNotifier.quantidadeItemAtual = _quantidadeAntiga;
    Navigator.pop(context);
  }
}
