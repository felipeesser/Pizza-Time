import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pizza_time/notifier/CarrinhoNotifier.dart';
import 'package:pizza_time/notifier/pedido_notifier.dart';

class Detalhes extends StatefulWidget {
  static final nomeTela = "/detalhes";
  Widget aux;
  @override
  _DetalhesState createState() => _DetalhesState();
}

void _chamada(String command) async {
  if (await canLaunch(command)) {
    await launch(command);
  } else {
    print('erro chamada');
  }
}

class _DetalhesState extends State<Detalhes> {
  CarrinhoNotifier _carrinhoNotifier;
  PedidoNotifier _pedidoNotifier;
  @override
  Widget build(BuildContext context) {
    _pedidoNotifier = Provider.of<PedidoNotifier>(context, listen: false);
    _carrinhoNotifier = Provider.of<CarrinhoNotifier>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text('Detalhes do Pedido'),
          centerTitle: true,
          backgroundColor: Color(0xFFbd1918),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Detalhes do pedido: ',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 100,
                      child: ListView.builder(
                        itemCount: _carrinhoNotifier
                            .carrinhoAtual.itensCarrinho.length,
                        itemBuilder: (context, indice) => Text(
                          '${_carrinhoNotifier.carrinhoAtual.itensCarrinho.elementAt(indice).item.nome}:x${_carrinhoNotifier.carrinhoAtual.itensCarrinho.elementAt(indice).quantidade}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Valor: R\$ ${_pedidoNotifier.pedidoAtual.valor}',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Pagamento: ${_pedidoNotifier.pedidoAtual.pagamento}',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              Divider(
                height: 100.0,
                thickness: 1.0,
                color: Color(0xFF000000),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Status do Pedido:',
                  style: TextStyle(fontSize: 22.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${_pedidoNotifier.pedidoAtual.statusPedido}',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: FlatButton(
                  onPressed: () {
                    _chamada('tel:21999999999');
                  },
                  child: Text(
                    'Contato com o restaurante',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              )
            ]));
  }
}
