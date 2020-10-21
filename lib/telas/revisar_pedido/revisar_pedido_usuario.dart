import 'package:flutter/material.dart';
import 'components/listview_pedido_usuario.dart';
import 'components/panel_resume_pedido_usuario.dart';
import '../finalizar_pedido/finalizar_pedido_route.dart';

/// Posiciona os widgets da tela onde o usuário revisa seu pedido.
///
/// ```dart
/// Navigator.pushNamed(context, [RevisarPedidoUsuario.nomeTela]);
/// ```
class RevisarPedidoUsuario extends StatelessWidget {
  static final String nomeTela = '/revisar_pedido_usuario';

  @override
  Widget build(BuildContext context) {
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
  /// essa tela será removida do Navegador também.
  _apresentarFinalizarPedido(BuildContext context) async {
    final res = await Navigator.pushNamed(
      context,
      FinalizarPedido.nomeTela,
    );
    // REVIEW - confirmar que essa condição está sendo satisfeita após a
    // implementação do backend.
    if (res is Map<String, dynamic> && res['pedido_realizado']) {
      Navigator.pop(context);
    }
  }
}
