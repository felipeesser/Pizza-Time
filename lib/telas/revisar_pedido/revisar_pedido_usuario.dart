import 'package:flutter/material.dart';
import 'package:pizza_time/notifier/CarrinhoNotifier.dart';
import 'package:provider/provider.dart';

import 'package:pizza_time/telas/home_files/Home.dart';
import 'package:pizza_time/telas/Detalhes.dart';
import 'package:pizza_time/telas/finalizar_pedido/finalizar_pedido_route.dart';

import './components/listview_pedido_usuario.dart';
import './components/panel_resume_pedido_usuario.dart';


/// Posiciona os widgets da tela onde o usuário revisa o carrinho do pedido.
///
/// ```dart
/// Navigator.pushNamed(context, [RevisarPedidoUsuario.nomeTela]);
/// ```
class RevisarPedidoUsuario extends StatelessWidget {
  static final String nomeTela = '/revisar_pedido_usuario';

  @override
  Widget build(BuildContext context) {
    final CarrinhoNotifier _carrinhoNotifier = Provider.of<CarrinhoNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Revisar Pedido'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            children: [
              Expanded(
                child: ListViewPedidoUsuario(),
              ),
              Divider(
                thickness: 1.5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: PanelResumePedidoUsuario(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(
                  child: Text('finalizar pedido'.toUpperCase()),
                  onPressed: () {
                    if (_carrinhoNotifier.carrinhoAtual.length <= 0) {
                      return;
                    }
                    _apresentarFinalizarPedido(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Empurra a tela FinalzarPedido no Navegador.
  ///
  /// Caso a tela FinalizarPedido retorne que o pedido foi realizado com sucesso
  /// esta tela também será removida do Navegador e a tela Detalhes será
  /// mostrada.
  _apresentarFinalizarPedido(BuildContext context) async {
    final res = await Navigator.pushNamed(
      context,
      FinalizarPedido.nomeTela,
    );
    // REVIEW - confirmar que essa condição está sendo satisfeita após a
    // implementação do backend.
    if (res ?? false) {
      Navigator.popUntil(context, ModalRoute.withName(Home.nomeTela));
      Navigator.pushNamed(context, Detalhes.nomeTela);
    }
  }
}