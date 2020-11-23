import 'package:flutter/material.dart';
import 'package:pizza_time/modelo/endereco.dart';
import 'package:pizza_time/modelo/possiveis_status_pedido.dart';

import 'package:provider/provider.dart';
import 'package:pizza_time/notifier/pedido_notifier.dart';
import 'package:pizza_time/api/endereco_firebase.dart' as enderecoFirebaseCrud;

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
  Endereco _endereco;

  String _statusAtual;
  final _status = PossiveisStatusPedido.values;

  @override
  void initState() async {
    super.initState();
    _pedidoNotifier = Provider.of<PedidoNotifier>(context);
    _endereco = await enderecoFirebaseCrud
        .enderecoFromPedido(_pedidoNotifier.pedidoAtual);
  }

  @override
  Widget build(BuildContext context) {
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
              onChanged: (String selecionado) {
                setState(() {
                  _statusAtual = selecionado;
                });
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
}
