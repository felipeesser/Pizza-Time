import 'package:flutter/material.dart';

import './panel_informacoes_entrega_restaurante.dart';
import './panel_resume_pedido_restaurante.dart';

/// Posiciona os widgets da aba detalhes do pedido.
class TabDetalhes extends StatelessWidget {
  static final nomeAba = 'Detalhes';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25),
      child: Column(
        children: [
          Expanded(
            child: PanelInformacoesEntregaRestaurante(),
          ),
          Divider(thickness: 1.5),
          Align(
            alignment: Alignment.bottomCenter,
            child: PanelResumePedidoRestaurante(),
          ),
        ],
      ),
    );
  }
}