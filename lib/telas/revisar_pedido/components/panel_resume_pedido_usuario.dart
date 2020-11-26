import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:pizza_time/notifier/CarrinhoNotifier.dart';

/// Apresenta um resumo das informações do pedido do cliente.
///
/// As informações em questão são: o total de itens do pedido e o subtotal do
/// pedido.
class PanelResumePedidoUsuario extends StatefulWidget {
  @override
  _PanelResumePedidoUsuarioState createState() =>
      _PanelResumePedidoUsuarioState();
}

class _PanelResumePedidoUsuarioState extends State<PanelResumePedidoUsuario> {
  CarrinhoNotifier _carrinhoNotifier;

  // @override
  // void initState() {
  //   super.initState();
  //   _carrinhoNotifier = Provider.of<CarrinhoNotifier>(context);
  // }

  @override
  Widget build(BuildContext context) {
    _carrinhoNotifier = Provider.of<CarrinhoNotifier>(context);
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
              child: Text('${_carrinhoNotifier.carrinhoAtual.quantidadeItens} itens'),
            ),
          ],
        ),
        TableRow(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text('Subtotal:'),
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
