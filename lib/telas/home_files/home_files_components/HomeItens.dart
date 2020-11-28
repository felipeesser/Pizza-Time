import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_time/notifier/ItemNotifier.dart';
import 'package:pizza_time/telas/home_files/Info_Item.dart';

class HomeItens extends StatelessWidget {
  ItemNotifier _itemNotifier;
  HomeItens(ItemNotifier itemNotifier) {
    this._itemNotifier = itemNotifier;
  }
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: _itemNotifier.listaFiltrada().length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            _itemNotifier.itemAtual =
                _itemNotifier.listaFiltrada().elementAt(index);
            Navigator.of(context).pushNamed(Info_Item.nomeTela);
          },
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 13, horizontal: 13),
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _itemNotifier.listaFiltrada().elementAt(index).imagem != null
                    ? Expanded(
                        child: FittedBox(
                            fit: BoxFit.fill,
                            child: Image.network(_itemNotifier
                                .listaFiltrada()
                                .elementAt(index)
                                .imagem)))
                    : Image.asset('Imagens/pizza.jpg'),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                          flex: 1,
                          child: Text(
                              _itemNotifier
                                  .listaFiltrada()
                                  .elementAt(index)
                                  .nome
                                  .toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12))),
                      Flexible(
                          flex: 2,
                          child: Text(
                              _itemNotifier
                                  .listaFiltrada()
                                  .elementAt(index)
                                  .descricao,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color.fromRGBO(89, 89, 89, 1),
                                fontSize: 12,
                              ))),
                      Divider(),
                      Flexible(
                          flex: 1,
                          child: Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Text(
                                      'R\$ ${_itemNotifier.listaFiltrada().elementAt(index).preco}',
                                      style: TextStyle(color: Colors.black))))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
