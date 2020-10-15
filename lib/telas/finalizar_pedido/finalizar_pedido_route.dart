import 'package:flutter/material.dart';
import 'components/form_finalizar_pedido.dart';

// preciso do tipo de dados do endereço

class FinalizarPedidoRoute extends StatelessWidget {
  static const String routeName = '/finalizar_pedido';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(routeName),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              FormFinalizarPedido(),
              Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(
                  child: Text('Pedir'.toUpperCase()),
                  onPressed: () {
                    _enviaPedidoBancoDados(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _enviaPedidoBancoDados(BuildContext context) {
    _conectaBancoDadosEnviaPedido();
    Navigator.pop(context, <String, dynamic>{'pedido_realizado': true});
  }

  void _conectaBancoDadosEnviaPedido() {
    // TODO - conectar e tratar das excessões que possam acontecer
    return;
  }
}
