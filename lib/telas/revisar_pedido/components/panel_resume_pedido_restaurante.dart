//import 'package:flutter/material.dart';
//// TODO - remover as referencias ao carrinho assim que discutirmos como será o backend.
//import 'Carrinho.dart';
//
///// Apresenta um resumo das informações do pedido do cliente para o restaurante.
/////
///// As informações em questão são: o total de itens do pedido e o subtotal do
///// pedido, o endereço para entrega e o status do pedido (pronto para entrega,
///// a caminho, aceito, etc...).
//class PanelResumePedidoRestaurante extends StatefulWidget {
//  @override
//  _PanelResumePedidoRestauranteState createState() =>
//      _PanelResumePedidoRestauranteState();
//}
//
//class _PanelResumePedidoRestauranteState
//    extends State<PanelResumePedidoRestaurante> {
//  Carrinho carrinho;
//
//  @override
//  void initState() {
//    // REVIEW - carrinho será pego do banco de dados ou recebido pelo construtor da classe.
//    carrinho = carrinhoTEMP;
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Table(
//      columnWidths: {0: FlexColumnWidth(0.5), 1: FlexColumnWidth()},
//      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//      children: [
//        TableRow(
//          children: [
//            Container(
//              alignment: Alignment.centerLeft,
//              child: Text('Quantidade:'),
//            ),
//            Container(
//              margin: EdgeInsets.symmetric(vertical: 5),
//              alignment: Alignment.centerRight,
//              child: Text('${carrinho.length} itens'),
//            ),
//          ],
//        ),
//        TableRow(
//          children: [
//            Container(
//              alignment: Alignment.centerLeft,
//              child: Text('Subtotal:'),
//            ),
//            Container(
//              margin: EdgeInsets.symmetric(vertical: 5),
//              alignment: Alignment.centerRight,
//              child: Text(
//                '${Carrinho.moeda} ${carrinho.subtotal.toStringAsFixed(2)}',
//                maxLines: 1,
//                style: Theme.of(context).textTheme.headline6,
//              ),
//            ),
//          ],
//        ),
//      ],
//    );
//  }
//}
