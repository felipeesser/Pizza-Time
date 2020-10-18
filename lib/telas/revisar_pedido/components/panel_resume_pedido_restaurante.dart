import 'package:flutter/material.dart';
// TODO - remover as referencias ao carrinho assim que discutirmos como será o backend.
import 'Carrinho.dart';

class PanelResumePedidoRestaurante extends StatefulWidget {
  @override
  _PanelResumePedidoRestauranteState createState() => _PanelResumePedidoRestauranteState();
}

class _PanelResumePedidoRestauranteState extends State<PanelResumePedidoRestaurante> {
  Carrinho carrinho;

  @override
  void initState() {
    // REVIEW - will be fetched from database or received on constructor
    carrinho = carrinhoTEMP;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Table(
        columnWidths: {0: FlexColumnWidth(0.4), 1: FlexColumnWidth()},
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
                child: Text('${carrinho.length} itens'),
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
                  '${Carrinho.moeda} ${carrinho.subtotal.toStringAsFixed(2)}',
                  maxLines: 1,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}