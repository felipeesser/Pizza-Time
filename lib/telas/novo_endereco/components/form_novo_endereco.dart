import 'package:flutter/material.dart';

/// Constrói formulário com os campos para cadastro de um endereço.
/// 
/// ```dart
/// ...
/// child: FormNovoEndereço(),
/// ...
/// ```
class FormNovoEndereco extends StatefulWidget {
  @override
  _FormNovoEnderecoState createState() => _FormNovoEnderecoState();
}

class _FormNovoEnderecoState extends State<FormNovoEndereco> {
  @override
  Widget build(BuildContext context) {
    // TODO - substituir pelo formulário de cadastro usado na tela de login.
    // return Form();
    return Container(
      height: 300,
      color: Colors.black45,
      alignment: Alignment.center,
      child: Text(
        'formulário do cadastro',
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }
}
