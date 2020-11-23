import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:pizza_time/notifier/CarrinhoNotifier.dart';

/// Apresenta um resumo das informações do pedido do cliente para o restaurante.
///
/// As informações em questão são: o total de itens do pedido e o subtotal do
/// pedido, o endereço para entrega e o status do pedido (pronto para entrega,
/// a caminho, aceito, etc...).
class PanelResumePedidoRestaurante extends StatefulWidget {
  @override
  _PanelResumePedidoRestauranteState createState() =>
      _PanelResumePedidoRestauranteState();
}

class _PanelResumePedidoRestauranteState
    extends State<PanelResumePedidoRestaurante> {
  CarrinhoNotifier _carrinhoNotifier;

  @override
  void initState() {
    super.initState();
    _carrinhoNotifier = Provider.of<CarrinhoNotifier>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: {0: FlexColumnWidth(0.5), 1: FlexColumnWidth()},
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text('Quantidade:'),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              alignment: Alignment.centerRight,
              child: Text('${_carrinhoNotifier.carrinhoAtual.length} itens'),
            ),
          ],
        ),
        TableRow(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text('Total:'),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              alignment: Alignment.centerRight,
              child: Text(
                'R\$ ${_carrinhoNotifier.carrinhoAtual.precoTotal.toStringAsFixed(2)}',
                maxLines: 1,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

