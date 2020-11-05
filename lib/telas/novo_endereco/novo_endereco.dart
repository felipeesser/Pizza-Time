// NOTE - essa rota foi desenvolvida para ser chamada a partir da rota finalizarPedido.

import 'package:flutter/material.dart';

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
  GlobalKey<FormState> _formNovoEnderecoKey;
  TextEditingController _controladorEndereco;
  TextEditingController _controladorNumero;
  TextEditingController _controladorComplemento;

  @override
  void initState() {
    super.initState();
    _formNovoEnderecoKey = GlobalKey<FormState>();
    _controladorEndereco = TextEditingController();
    _controladorNumero = TextEditingController();
    _controladorComplemento = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo endereço'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: SingleChildScrollView(
            child: Form(
              key: _formNovoEnderecoKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _controladorEndereco,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Endereço*',
                      hintText: 'Endereço para entrega',
                      helperText: '*Requerido',
                    ),
                    validator: (value) => _validarEndereco(value),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _controladorNumero,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Número*',
                      hintText: 'número...',
                      helperText: '*Requerido',
                    ),
                    validator: (value) => _validarNumero(value),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _controladorComplemento,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Complemento*',
                      hintText: 'complemento...',
                      helperText: '*Requerido',
                    ),
                    validator: (value) => _validarComplemento(value),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        RaisedButton(
          padding: Theme.of(context).buttonTheme.padding,
          child: Text(
            'salvar'.toUpperCase(),
            style: Theme.of(context).textTheme.button.copyWith(
                  color: Theme.of(context).accentColor,
                ),
          ),
          onPressed: () {
            if (_salvarEndereco()) {
              // se salvar endereço, ocorreu com sucesso então volte
              Navigator.pop(context);
            }
          },
        ),
        FlatButton(
          padding: Theme.of(context).buttonTheme.padding,
          child: Text(
            'cancelar'.toUpperCase(),
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  /// Avalia o endereço seguindo as regras definidas para a avaliação.
  _validarEndereco(String value) {
    if (value.isEmpty) {
      return 'Preencha o endereço';
    }
    return null;
  }

  /// Avalia o endereço seguindo as regras definidas para a avaliação.
  _validarNumero(String value) {
    if (value.isEmpty) {
      return 'Preencha o número';
    }
    return null;
  }

  /// Avalia o endereço seguindo as regras definidas para a avaliação.
  _validarComplemento(String value) {
    if (value.isEmpty) {
      return 'Preencha o compelemento';
    }
    return null;
  }

  /// Armazena o endereço fornecido.
  ///
  /// O endereço fornecido não deve ser armazenado por tempo indefinido no perfil
  /// do cliente.
  _salvarEndereco() {
    final valores = {
      'endereco': _controladorEndereco.value.text,
      'numero': _controladorNumero.value.text,
      'complemento': _controladorComplemento.value.text,
    };
    // verdadeiro se o formulario for válido, falso caso contrário.
    if (_formNovoEnderecoKey.currentState.validate()) {
      // TODO - salvar o endereço no banco de dados;
      print(valores);
      return true;
    }
    return false;
  }

  /// Desaloca componentes criados para esse widget.
  @override
  void dispose() {
    _controladorEndereco.dispose();
    _controladorNumero.dispose();
    _controladorComplemento.dispose();
    super.dispose();
  }
}
