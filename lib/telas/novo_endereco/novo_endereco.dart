// NOTE - essa rota foi desenvolvida para ser chamada a partir da rota finalizarPedido.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:pizza_time/api/endereco_firebase.dart' as enderecoFirebaseCrud;
import 'package:pizza_time/modelo/endereco.dart';

/// Posiciona os widgets da tela onde o usuário pode cadastrar um novo endereço.
///
/// ```dart
/// Navigator.pushNamed(context, NovoEndereco.nomeTela);
/// ```
class NovoEndereco extends StatefulWidget {
  static const nomeTela = '/novo_endereco';
  @override
  _NovoEnderecoState createState() => _NovoEnderecoState();
}

class _NovoEnderecoState extends State<NovoEndereco> {
  GlobalKey<FormState> _formNovoEnderecoKey;
  String _rua;
  String _numero;
  String _complemento;
  Endereco _novoEndereco;

  @override
  void initState() {
    super.initState();
    _formNovoEnderecoKey = GlobalKey<FormState>();
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
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Endereço*',
                      hintText: 'Endereço para entrega',
                      helperText: '*Obrigatório',
                    ),
                    validator: (value) => _validarEndereco(value),
                    onSaved: (newValue) {
                      _rua = newValue;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Número*',
                      hintText: 'número...',
                      helperText: '*Obrigatório',
                    ),
                    validator: (value) => _validarNumero(value),
                    onSaved: (newValue) {
                      _numero = newValue;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Complemento*',
                      hintText: 'complemento...',
                      helperText: '*Obrigatório',
                    ),
                    validator: (value) => _validarComplemento(value),
                    onSaved: (newValue) {
                      _complemento = newValue;
                    },
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
          onPressed: () async {
            if (await _salvarEndereco()) {
              Navigator.pop<Endereco>(context, _novoEndereco);
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
    if (value.runtimeType == String && value.isEmpty) {
      return 'Preencha o endereço';
    }
    return null;
  }

  /// Avalia o numero seguindo as regras definidas para a avaliação.
  _validarNumero(String value) {
    if (value.runtimeType == String && value.isEmpty) {
      return 'Preencha o número';
    }
    return null;
  }

  /// Avalia o complemento seguindo as regras definidas para a avaliação.
  _validarComplemento(String value) {
    if (value.runtimeType == String && value.isEmpty) {
      return 'Preencha o compelemento';
    }
    return null;
  }

  /// Armazena o endereço fornecido.
  ///
  /// O endereço fornecido não deve ser armazenado por tempo indefinido no perfil
  /// do cliente.
  _salvarEndereco() async {
    // verdadeiro se o formulario for válido, falso caso contrário.
    if (_formNovoEnderecoKey.currentState.validate()) {
      _formNovoEnderecoKey.currentState.save();
      _novoEndereco = Endereco(rua: _rua, numero: _numero, complemento: _complemento);
      // TODO - checar se utilizaremos provider para o usuario ou não;
      final usuarioAux = await FirebaseAuth.instance.currentUser();
      enderecoFirebaseCrud.create(endereco: _novoEndereco, idUsuario: usuarioAux.uid);
      return true;
    }
    return false;
  }
}
