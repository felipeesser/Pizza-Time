import 'package:pizza_time/notifier/pedido_notifier.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:pizza_time/modelo/carrinho.dart';
import 'package:pizza_time/api/endereco_firebase.dart' as enderecoFirebaseCrud;
import 'package:pizza_time/api/pedido_firebase.dart' as pedidoFirebaseCrud;
import 'package:pizza_time/modelo/endereco.dart';
import 'package:pizza_time/modelo/pedido.dart';
import 'package:pizza_time/telas/home_files/Detalhes.dart';
import 'package:pizza_time/telas/home_files/Pedidos_Feitos.dart';
import 'package:pizza_time/notifier/CarrinhoNotifier.dart';

class Pedidos_Feitos_Card extends StatelessWidget {
  // Future<Pedido> _umFuturoPedido;
  Future<bool> _consultouFirebase;
  Pedido _pedido;
  Endereco _endereco;
  Widget aux;
  CarrinhoNotifier _littleCar;
  Carrinho _carrinho;
  PedidoNotifier _pedidoNotifier;

  Pedidos_Feitos_Card(Pedido pedido) {
    this._pedido = pedido;
    _consultouFirebase = _consultaFirebase();
  }

  @override
  Widget build(BuildContext context) {
    _pedidoNotifier = Provider.of<PedidoNotifier>(context, listen: false);
    _littleCar = Provider.of<CarrinhoNotifier>(context, listen: false);
    return Container(
      child: FutureBuilder(
        future: _consultouFirebase,
        builder: _futureBuilderCard,
      ),
      color: Colors.white,
    );
  }

  /// Consulta todos os dados associados ao futurePedido fornecido.
  Future<bool> _consultaFirebase() async {
    _carrinho = await pedidoFirebaseCrud.carrinhoFromPedido(_pedido);
    aux = Container(
      height: 100,
      child: ListView.builder(
        itemCount: _carrinho.itensCarrinho.length,
        itemBuilder: (context, indice) => Text(
            '${_carrinho.itensCarrinho.elementAt(indice).item.nome}:x${_carrinho.itensCarrinho.elementAt(indice).quantidade}'),
      ),
    );
    _endereco = await enderecoFirebaseCrud.enderecoFromPedido(_pedido);
    return (_pedido != null) && (_endereco != null) ? true : false;
  }

  /// Constrói o widget apropriado dependendo do andamento da consulta aos dados.
  Widget _futureBuilderCard(
      BuildContext context, AsyncSnapshot<bool> snapshot) {
    // Função para auxiliar na legibilidade
    Widget _carregando() {
      return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            Text(
              'Carregando pedidos...',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      );
    }

    // Função para auxiliar na legibilidade
    Widget _algoDeuErrado() {
      return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Oops!',
              style: Theme.of(context).textTheme.headline3,
            ),
            Text(
              'Tente novamente mais tarde :(',
            ),
          ],
        ),
      );
    }

    // Função para auxiliar na legibilidade
    Widget _conteudoCompleto() {
      return GestureDetector(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Endereço:',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(height: 8),
                Text(
                  '$_endereco',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Text(
                  'Forma de Pagamento:',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(height: 8),
                Text('${_pedido.pagamento}'),
                SizedBox(height: 8),
                Text(
                  'Pizza(s):',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: 8,
                ),
                aux,
              ],
            ),
          ),
        ),
        onTap: () async {
          Carrinho carrinhoAntigo = _littleCar.carrinhoAtual;
          _littleCar.carrinhoAtual = _carrinho;
          _pedidoNotifier.pedidoAtual = _pedido;
          await Navigator.of(context).pushNamed(Detalhes.nomeTela);
          _littleCar.carrinhoAtual = carrinhoAntigo;
        },
      );
    }

    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return _algoDeuErrado();
      } else {
        return _conteudoCompleto();
      }
    } else {
      return _carregando();
    }
  }
}
