import 'package:flutter/material.dart';
import 'components/listview_carrinho.dart';
import 'components/panel_resume_carrinho.dart';
import '../finalizar_pedido/finalizar_pedido_route.dart';

class RevisarPedidoUsuarioRoute extends StatelessWidget {
  static final String routeName = '/revisar_pedido_usuario';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(routeName),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            children: [
              Expanded(
                child: ListViewCarrinho(),
              ),
              Divider(
                thickness: 1.5,
              ),
              PanelResumeCarrinho(),
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

  _apresentarFinalizarPedido(BuildContext context) async {
    final res = await Navigator.pushNamed(
      context,
      FinalizarPedidoRoute.routeName,
    );
    if (res is Map<String, dynamic> && res['pedido_realizado']) {
      Navigator.pop(context);
    }
  }
}
