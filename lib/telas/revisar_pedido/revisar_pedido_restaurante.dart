import 'package:flutter/material.dart';
import 'components/tab_produtos.dart';
import 'components/tab_detalhes.dart';

/// Posiciona os widgets da tela onde o restaurante visualiza o pedido de um cliente.
///
/// ```dart
/// Navigator.pushNamed(context, [RevisarPedidoRestaurante.nomeTela]);
/// ```
class RevisarPedidoRestaurante extends StatelessWidget {
  static final String nomeTela = '/revisar_pedido_restaurante';
  final Map<String, Widget> abas = {
    TabProdutos.nomeAba: TabProdutos(),
    TabDetalhes.nomeAba: TabDetalhes(),
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Visualizar Pedido'),
          bottom: TabBar(
            tabs: abas.keys.map((String s) => Tab(text: s)).toList(),
          ),
        ),
        body: TabBarView(
          children: abas.values.toList(),
        ),
      ),
    );
  }
}
