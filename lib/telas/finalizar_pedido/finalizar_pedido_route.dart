import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:pizza_time/api/endereco_firebase.dart' as enderecoFirebaseCrud;
import 'package:pizza_time/api/pedido_firebase.dart' as pedidoFirebaseCrud;
import 'package:pizza_time/modelo/endereco.dart';
import 'package:pizza_time/modelo/possiveis_formas_pagamento.dart';
import 'package:pizza_time/modelo/pedido.dart';
import 'package:pizza_time/modelo/possiveis_status_pedido.dart';
import 'package:pizza_time/notifier/CarrinhoNotifier.dart';
import 'package:pizza_time/telas/novo_endereco/novo_endereco.dart';

// import './components/form_finalizar_pedido.dart';

/// Posiciona os widgets da tela onde o usuário revisa seu pedido.
///
/// ```dart
/// Navigator.pushNamed(context, [FinalizarPedido.nomeTela]);
/// ```
class FinalizarPedido extends StatefulWidget {
  static const String nomeTela = '/finalizar_pedido';

  @override
  _FinalizarPedidoState createState() => _FinalizarPedidoState();
}

class _FinalizarPedidoState extends State<FinalizarPedido> {
  // TODO - checar se utilizaremos provider para o usuario ou não;
  FirebaseUser _usuario;
  CarrinhoNotifier _carrinhoNotifier;

  final _formKey = GlobalKey<FormState>();
  String _formaPagamentoAtual;
  String _formaPagamentoSelecionada;
  final _formasPagamento = PossiveisFormasPagamento.values;
  Endereco _enderecoEntregaSelecionado;
  List<Endereco> _enderecosEntrega;
  final _labelOutroEndereco = 'Outro endereço...';
  final _valueOutroEndereco = Endereco();

  @override
  void initState() async {
    super.initState();
    _usuario = await FirebaseAuth.instance.currentUser();
    _carrinhoNotifier = Provider.of<CarrinhoNotifier>(context);
    _enderecosEntrega =
        await enderecoFirebaseCrud.endrecosFromUsuario(_usuario.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FinalizarPedido.nomeTela),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              _formFinalizarPedido(context),
              Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(
                  child: Text('Pedir'.toUpperCase()),
                  onPressed: () {
                    if (_carrinhoNotifier.carrinhoAtual.length <= 0) {
                      return;
                    }
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      _enviaPedidoBancoDados(context);
                      Navigator.pop(context, true);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Constrói um formulário para a finalização da entrega.
  ///
  /// Os campos desse formulário são modo de pagamento, e endereço para entrega.
  ///
  /// ```dart
  /// ...
  /// child: FormFinalizarPedido(),
  /// ...
  /// ```
  Widget _formFinalizarPedido(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: 16),
            child: Text(
              'Forma de pagamento:',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          _selecaoFormaPagamento(),
          SizedBox(height: 24),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: 16),
            child: Text(
              'Endereço para entrega:',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          _selecaoEnderecoEntrega(context),
        ],
      ),
    );
  }

  /// Contrói o campo para seleção do método de pagamento.
  _selecaoFormaPagamento() {
    return DropdownButtonFormField<String>(
      value: _formaPagamentoAtual,
      hint: Text('Forma de pagamento...'),
      items: _formasPagamento
          .map<DropdownMenuItem<String>>(
              (String s) => DropdownMenuItem(value: s, child: Text(s)))
          .toList(),
      onChanged: (String opcao) {
        setState(() {
          _formaPagamentoAtual = opcao;
        });
      },
      onSaved: (String opcao) {
        _formaPagamentoSelecionada = opcao;
      },
    );
  }

  /// Contrói o campo para seleção do endereço de entrega.
  _selecaoEnderecoEntrega(BuildContext context) {
    return DropdownButtonFormField<Endereco>(
      value: _enderecoEntregaSelecionado,
      hint: Text('Entregar em...'),
      isExpanded: true,
      items: [
        ..._enderecosEntrega
            .map<DropdownMenuItem<Endereco>>(
              (Endereco e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
            .toList(),
        DropdownMenuItem(
          value: _valueOutroEndereco,
          child: Text(_labelOutroEndereco),
        ),
      ],
      onChanged: (Endereco opcao) async {
        if (opcao == _valueOutroEndereco) {
          // _navegarMostrarNovoEnderecoRoute();
          if (await Navigator.pushNamed(context, NovoEndereco.nomeTela) ??
              false) {
            setState(() async {
              _enderecosEntrega =
                  await enderecoFirebaseCrud.endrecosFromUsuario(_usuario.uid);
            });
          }
        } else {
          setState(() {
            _enderecoEntregaSelecionado = opcao;
          });
        }
      },
      validator: (Endereco opcao) {
        if (opcao == _valueOutroEndereco) {}
        return;
      },
    );
  }

  /// Envia o pedido para o banco de dados.
  void _enviaPedidoBancoDados(BuildContext context) {
    final pedido = Pedido(
      idUsuario: _usuario.uid,
      idEndereco: _enderecoEntregaSelecionado.idEndereco,
      pagamento: _formaPagamentoSelecionada,
      statusPedido: PossiveisStatusPedido.naFila,
    );
    pedido.idsItemQuantidadeFromCarrinho(_carrinhoNotifier.carrinhoAtual);
    pedidoFirebaseCrud.create(pedido);
    _carrinhoNotifier.esvaziarCarrinho();
  }
}
