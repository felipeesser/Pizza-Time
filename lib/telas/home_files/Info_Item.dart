import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_time/modelo/Item.dart';
import 'package:pizza_time/modelo/carrinho.dart';
import 'package:pizza_time/modelo/item_carrinho.dart';
import 'package:pizza_time/notifier/ItemNotifier.dart';
import 'package:provider/provider.dart';
import 'package:pizza_time/notifier/CarrinhoNotifier.dart';
class Info_Item extends StatefulWidget {
  static final nomeTela = "/info_item";
  @override
  _Info_ItemState createState() => _Info_ItemState();
}

class _Info_ItemState extends State<Info_Item> {
  int _cont = 1;
  double _total;

  double _calculo(int cont, double preco) {
    return cont * preco;
  }

  @override
  Widget build(BuildContext context) {
    ItemNotifier itemNotifier = Provider.of<ItemNotifier>(context);
    CarrinhoNotifier carrinhoNotifier = Provider.of<CarrinhoNotifier>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          itemNotifier.itemAtual.imagem != null
              ? Expanded(
              flex: 2,
              child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.network(itemNotifier.itemAtual.imagem)))
              : Image.asset('Imagens/pizza.jpg'),
          Flexible(
              child: Text(
                itemNotifier.itemAtual.nome.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                textAlign: TextAlign.center,
              )),
          Flexible(
              child: Text(
                  itemNotifier.itemAtual.descricao)),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: {0: FractionColumnWidth(.5)},
            children: [
              TableRow(children: [
                Text('Preço:'),
                Align(alignment: Alignment.center,
                    child: Text('R\$ ${itemNotifier.itemAtual.preco}')),
              ]),
              TableRow(children: [
                Text('Quantidade:'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: FlatButton(
                          padding: EdgeInsets.zero,
                          shape: CircleBorder(),
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                          color: Colors.red,
                          onPressed: () {
                            setState(() {
                              if (_cont > 1) _cont--;
                              _total = _calculo(_cont,
                                  double.parse(itemNotifier.itemAtual.preco));
                            });
                          }),
                    ),
                    Text('$_cont'),
                    Flexible(
                      child: FlatButton(
                          padding: EdgeInsets.zero,
                          shape: CircleBorder(),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          color: Colors.green,
                          onPressed: () {
                            setState(() {
                              _cont++;
                              _total = _calculo(_cont,
                                  double.parse(itemNotifier.itemAtual.preco));
                            });
                          }),
                    ),
                  ],
                )
              ]),
              TableRow(children: [
                Divider(
                  color: Color.fromRGBO(204, 41, 0, 1),
                  thickness: 2,
                ),
                Divider(
                  color: Color.fromRGBO(204, 41, 0, 1),
                  thickness: 2,
                ),
              ]),
              TableRow(children: [
                Text('Total:'),
                Align(alignment: Alignment.center,
                    child: Text('R\$ ${(_total == null)
                        ? itemNotifier.itemAtual.preco
                        : _total}'))
              ]),
            ],
          ),
          FlatButton(
              child: Text(
                "Adicionar",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              color: Color.fromRGBO(204, 41, 0, 1),
              padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
              shape: RoundedRectangleBorder(
                //side: BorderSide(color: Colors.black,width: 3),
                  borderRadius: BorderRadius.circular(32)),
              onPressed: () {
                carrinhoNotifier.adicionarItem(ItemCarrinho(item:itemNotifier.itemAtual,quantidade:_cont));
              })
        ],
      ),
    );
  }
}