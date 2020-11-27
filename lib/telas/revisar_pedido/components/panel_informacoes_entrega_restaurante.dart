import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pizza_time/api/endereco_firebase.dart' as enderecoFirebaseCrud;
import 'package:pizza_time/api/usuario_firestore.dart' as usuarioFirebaseCrud;
import 'package:pizza_time/api/pedido_firebase.dart' as pedidoFirebaseCrud;
import 'package:pizza_time/modelo/Usuario.dart';
import 'package:pizza_time/modelo/endereco.dart';
import 'package:pizza_time/modelo/possiveis_status_pedido.dart';
import 'package:pizza_time/notifier/pedido_notifier.dart';

/// Apresenta um resumo das informações de entrega do pedido do cliente.
///
/// As informações em questão são: status do pedido e o endereço para entrega do
/// pedido.
class PanelInformacoesEntregaRestaurante extends StatefulWidget {
  @override
  _PanelInformacoesEntregaRestauranteState createState() =>
      _PanelInformacoesEntregaRestauranteState();
}

class _PanelInformacoesEntregaRestauranteState
    extends State<PanelInformacoesEntregaRestaurante> {
  Future<bool> _consultouFirebase;
  Usuario _usuario;
  Endereco _endereco;

  String _statusAtual;

  PedidoNotifier _pedidoNotifier;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _pedidoNotifier = Provider.of<PedidoNotifier>(context, listen: false);
    if (_consultouFirebase == null) {
      _consultouFirebase = _consultaFirebase();
    }
    return FutureBuilder(
      future: _consultouFirebase,
      builder: _futureBuilder,
    );
  }

  /// Consulta todos os dados associados a esse pedido fornecido.
  Future<bool> _consultaFirebase() async {
    _usuario = await usuarioFirebaseCrud.read(
      usuarioFirebaseCrud
          .documentoUsuario(_pedidoNotifier.pedidoAtual.idUsuario),
    );
    _endereco = await enderecoFirebaseCrud
        .enderecoFromPedido(_pedidoNotifier.pedidoAtual);
    return ((_usuario != null) && (_endereco != null)) ? true : false;
  }

  /// Retorna o widget que será mostrado na tela
  ///
  /// O widget que será mostrado depende do status da snapshot.
  Widget _futureBuilder(BuildContext context, AsyncSnapshot snapshot) {
    /// Mostra um circulo para sinalizar o carregamento.
    Widget _carregando() {
      return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            Text(
              'Carregando dados...',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      );
    }

    /// Mostra aviso.
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

    /// Mostra o widget que deveria ser mostrado de início.
    Widget _conteudoCompleto() {
      return Table(
        columnWidths: {},
        children: [
          TableRow(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  'Status do pedido:',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              DropdownButtonFormField(
                value: _pedidoNotifier.statusPedidoAtual,
                hint: Text('Status atual do pedido'),
                isExpanded: true,
                items: PossiveisStatusPedido.values
                    .map<DropdownMenuItem<String>>(
                      (String s) => DropdownMenuItem(
                        value: s,
                        child: Text(
                          s,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (String opcao) {
                  if (opcao != _statusAtual) {
                    setState(() {
                      _pedidoNotifier.statusPedidoAtual = opcao;
                      pedidoFirebaseCrud.update(_pedidoNotifier.pedidoAtual);
                    });
                  }
                },
              ),
            ],
          ),
          TableRow(children: [
            SizedBox(height: 16),
          ]),
          TableRow(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  'Endereço para entrega:',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              Text('${_endereco.toString()}'),
            ],
          ),
        ],
      );
    }

    /// Decide o que será mostrado
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
