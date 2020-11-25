import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pizza_time/modelo/Usuario.dart';
import 'package:pizza_time/modelo/endereco.dart';
import 'package:pizza_time/modelo/possiveis_status_pedido.dart';

import 'package:provider/provider.dart';
import 'package:pizza_time/notifier/pedido_notifier.dart';
import 'package:pizza_time/api/endereco_firebase.dart' as enderecoFirebaseCrud;
import 'package:pizza_time/api/usuario_firestore.dart' as usuarioFirebaseCrud;

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
  PedidoNotifier _pedidoNotifier;
  Usuario _usuario;
  Endereco _endereco;

  String _statusAtual;
  String _statusSelecionado;
  Future<bool> _consultouFirebase;
  final _status = PossiveisStatusPedido.values;

  @override
  void initState() {
    super.initState();
    _consultouFirebase = _consultaFirebase();
  }

  @override
  Widget build(BuildContext context) {
    _pedidoNotifier = Provider.of<PedidoNotifier>(context);
    return FutureBuilder(
      future: _consultouFirebase,
      builder: _futureBuilder,
    );
  }

  /// Consulta todos os dados associados a esse pedido fornecido.
  Future<bool> _consultaFirebase() async {
    _usuario = await usuarioFirebaseCrud.read(
      usuarioFirebaseCrud.documentoUsuario(_pedidoNotifier.pedidoAtual.idUsuario),
    );
    _endereco = await enderecoFirebaseCrud.enderecoFromPedido(_pedidoNotifier.pedidoAtual);
    return (_usuario != null) && (_endereco != null)
        ? true
        : false;
  }

  Widget _futureBuilder(BuildContext context, AsyncSnapshot snapshot) {
    // Função para auxiliar na legibilidade
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
                value: _statusAtual,
                hint: Text('Status atual do pedido'),
                isExpanded: true,
                items: _status
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
                  setState(() {
                    _statusAtual = opcao;
                  });
                },
                onSaved: (String opcao) {
                  _statusSelecionado = opcao;
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
