import 'package:flutter/material.dart';

/// Constrói formulário com os campos para cadastro de um endereço.
///
/// ```dart
/// ...
/// child: FormNovoEndereço(),
/// ...
/// ```
class FormNovoEndereco extends StatefulWidget {
  FormNovoEndereco({Key key}) : super(key: key);

  @override
  _FormNovoEnderecoState createState() => _FormNovoEnderecoState();
}

// TODO - acrescentar os TextEditingController
class _FormNovoEnderecoState extends State<FormNovoEndereco> {
  final _formNovoEnderecoKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formNovoEnderecoKey,
      autovalidate: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          TextFormField(
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

  // retorna os informações preechidas no formulário.
  getInfos() {
    // verdadeiro se o formulario for válido, falso caso contrário.
    if (_formNovoEnderecoKey.currentState.validate()) {
      print('valores retornados');
      return {'endereco': '', 'numero': 0, 'complemento': ''};
    }
    return null;
  }

  /// Desaloca componentes criados para esse widget.
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
