// NOTE - essa rota foi desenvolvida para ser chamada a partir da rota finalizarPedido.

import 'package:flutter/material.dart';
import 'components/form_novo_endereco.dart';

/// Posiciona os widgets da tela onde o usuário revisa seu pedido.
///
/// ```dart
/// Navigator.pushNamed(context, [NovoEndereco.nomeTela]);
/// ```
class NovoEndereco extends StatefulWidget {
  static const nomeTela = '/novo_endereco';
  @override
  _NovoEnderecoState createState() => _NovoEnderecoState();
}

class _NovoEnderecoState extends State<NovoEndereco> {
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

  /// Armazena temporariamente o endereço fornecido.
  ///
  /// O endereço fornecido não deve ser ramzenado por tempo indefinido no perfil
  /// do cliente.
  _salvarEndereco() {
    // TODO - salvar o endereço no banco de dados;
    return;
  }
}
