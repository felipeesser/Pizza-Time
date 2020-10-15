// NOTE - essa rota foi desenvolvida para ser chamada a partir da rota finalizarPedido.

import 'package:flutter/material.dart';
import 'components/form_novo_endereco.dart';

class NovoEnderecoRoute extends StatefulWidget {
  static const routeName = '/novo_endereco';
  @override
  _NovoEnderecoRouteState createState() => _NovoEnderecoRouteState();
}

class _NovoEnderecoRouteState extends State<NovoEnderecoRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo endereço'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              FormNovoEndereco(),
              Spacer(),
              ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [
                  RaisedButton(
                      child: Text('salvar'.toUpperCase()),
                      onPressed: () {
                        _salvarEndereco();
                        // se salvar endereço ocorreu com sucesso então volte
                        Navigator.pop(context);
                      }),
                  FlatButton(
                    child: Text('cancelar'.toUpperCase()),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _salvarEndereco() {
    // TODO - salvar o endereço no banco de dados;
    return;
  }
}
