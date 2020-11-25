import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:pizza_time/api/endereco_firebase.dart' as enderecoFirebaseCrud;
import 'package:pizza_time/api/usuario_firestore.dart' as usuarioFirebaseCrud;
import 'package:pizza_time/api/pedido_firebase.dart' as pedidoFirebaseCrud;
import 'package:pizza_time/modelo/endereco.dart';
import 'package:pizza_time/modelo/pedido.dart';
import 'package:pizza_time/modelo/Usuario.dart';
import 'package:pizza_time/notifier/CarrinhoNotifier.dart';
import 'package:pizza_time/notifier/pedido_notifier.dart';
import 'package:pizza_time/telas/revisar_pedido/revisar_pedido_restaurante.dart';

class CardPedido extends StatelessWidget {
  // Future<Pedido> _umFuturoPedido;
  Future<bool> _consultouFirebase;
  Pedido _pedido;
  Endereco _endereco;
  Usuario _usuario;

  PedidoNotifier _pedidoNotifier;
  CarrinhoNotifier _carrinhoNotifier;

  CardPedido(Pedido pedido) {
    this._pedido = pedido;
    _consultouFirebase = _consultaFirebase();
  }

  @override
  Widget build(BuildContext context) {
    _pedidoNotifier = Provider.of<PedidoNotifier>(context, listen: false);
    _carrinhoNotifier = Provider.of<CarrinhoNotifier>(context, listen: false);
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
    _usuario = await usuarioFirebaseCrud.read(
      usuarioFirebaseCrud.documentoUsuario(_pedido.idUsuario),
    );
    _endereco = await enderecoFirebaseCrud.enderecoFromPedido(_pedido);
    return (_pedido != null) && (_usuario != null) && (_endereco != null)
        ? true
        : false;
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Nome: ${_usuario.nome}',
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    IconButton(
                      constraints: BoxConstraints.tightFor(),
                      icon: Icon(Icons.call,
                          color: Theme.of(context).iconTheme.color),
                      iconSize: 26,
                      onPressed: () {
                        _chamada('tel:${_usuario.telefone}}');
                      },
                    ),
                  ],
                ),
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
              ],
            ),
          ),
        ),
        onTap: () async {
          _pedidoNotifier.pedidoAtual = _pedido;
          _carrinhoNotifier.carrinhoAtual = await pedidoFirebaseCrud.carrinhoFromPedido(_pedido);
          await Navigator.of(context).pushNamed(RevisarPedidoRestaurante.nomeTela);
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

  void _chamada(String command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('erro chamada');
    }
  }
}
