import 'package:flutter/material.dart';
import 'components/tab_produtos.dart';
import 'components/tab_detalhes.dart';

class RevisarPedidoRestauranteRoute extends StatelessWidget {
  static final String routeName = '/revisar_pedido_restaurante';
  final Map<String, Widget> abas = {
    TabProdutos.tabName: TabProdutos(),
    TabDetalhes.tabName: TabDetalhes(),
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Revisar Pedido'),
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
