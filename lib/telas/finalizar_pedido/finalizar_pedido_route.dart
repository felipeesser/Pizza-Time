import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pizza_time/api/endereco_firebase.dart' as enderecoFirebaseCrud;
import 'package:pizza_time/api/pedido_firebase.dart' as pedidoFirebaseCrud;
import 'package:pizza_time/modelo/endereco.dart';
import 'package:pizza_time/modelo/pedido.dart';
import 'package:pizza_time/modelo/possiveis_formas_pagamento.dart';
import 'package:pizza_time/modelo/possiveis_status_pedido.dart';
import 'package:pizza_time/notifier/CarrinhoNotifier.dart';
import 'package:pizza_time/telas/novo_endereco/novo_endereco.dart';

/// Posiciona os widgets da tela onde o usuário revisa seu carrinho.
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
  FirebaseUser _usuario;
  CarrinhoNotifier _carrinhoNotifier;

  final _formKey = GlobalKey<FormState>();
  String _formaPagamentoAtual;
  String _formaPagamentoSelecionada;
  final _formasPagamento = PossiveisFormasPagamento.values;
  Endereco _enderecoEntregaAtual;
  Endereco _enderecoEntregaSelecionado;
  Future<List<Endereco>> _futureEnderecosEntrega;
  List<Endereco> _enderecosEntrega;
  final _labelOutroEndereco = 'Outro endereço...';
  final _valueOutroEndereco = Endereco();

  @override
  void initState() {
    super.initState();
    _futureEnderecosEntrega = _consultaEnderecos();
  }

  /// Obtem a lista de endereços do usuario atual e o usuário atual caso necessário.
  Future<List<Endereco>> _consultaEnderecos() async {
    var aux = enderecoFirebaseCrud.endrecosFromUsuario(_usuario == null
        ? await FirebaseAuth.instance.currentUser().then((value) {
            _usuario = value;
            return _usuario.uid;
          })
        : _usuario.uid);
    return aux;
  }

  @override
  Widget build(BuildContext context) {
    _carrinhoNotifier = Provider.of<CarrinhoNotifier>(context);
    return Scaffold(
      appBar: AppBar(title: Text(FinalizarPedido.nomeTela)),
      body: SafeArea(
        child: FutureBuilder(
          future: _futureEnderecosEntrega,
          builder: _futureBuilder,
        ),
      ),
    );
  }

  /// Constrói o widget apropriado dependendo do andamento da consulta aos
  /// endereços
  Widget _futureBuilder(
      BuildContext context, AsyncSnapshot<List<Endereco>> snapshot) {
    // Função para auxiliar na legibilidade
    Widget _carregando() {
      return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            Text(
              'Carregando dados...',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      );
    }

    // Função para auxiliar na legibilidade
    Widget _algoDeuErrado() {
      return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Oops!',
              style: Theme.of(context).textTheme.headline2,
            ),
            Text(
              'Tente novamente mais tarde :(',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      );
    }

    // Função para auxiliar na legibilidade
    Widget _mostraConteudoCompleto() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            _formFinalizarPedido(context),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                child: Text('Pedir'.toUpperCase()),
                onPressed: _acaoBotaoPedir,
              ),
            ),
          ],
        ),
      );
    }

    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return _algoDeuErrado();
      } else {
        _enderecosEntrega = snapshot.data;
        return _mostraConteudoCompleto();
      }
    } else {
      return _carregando();
    }
  }

  /// Constrói um formulário para a finalização da entrega.
  ///
  /// Os campos desse formulário são: modo de pagamento, e endereço para entrega.
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
              'Forma de pagamento:*',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          _selecaoFormaPagamento(),
          SizedBox(height: 24),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: 16),
            child: Text(
              'Endereço para entrega:*',
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
      decoration: InputDecoration(helperText: '*Obrigatório'),
      items: _formasPagamento
          .map<DropdownMenuItem<String>>(
              (String s) => DropdownMenuItem(value: s, child: Text(s)))
          .toList(),
      onChanged: (String opcao) {
        _formaPagamentoAtual = opcao;
      },
      onSaved: (String opcao) {
        _formaPagamentoSelecionada = opcao;
      },
      validator: _validarOpcaoPagamento,
    );
  }

  /// Contrói o campo para seleção do endereço de entrega.
  _selecaoEnderecoEntrega(BuildContext context) {
    return DropdownButtonFormField<Endereco>(
      value: _enderecoEntregaAtual,
      hint: Text('Entregar em...\n'),
      decoration: InputDecoration(helperText: '*Obrigatório'),
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
            .toList()
              ..sort(
                  (a, b) => a.value.toString().compareTo(b.value.toString())),
        DropdownMenuItem(
          value: _valueOutroEndereco,
          child: Text(_labelOutroEndereco),
        ),
      ],
      onChanged: (Endereco opcao) async {
        if (opcao == _valueOutroEndereco) {
          var novoEndereco =
              await Navigator.pushNamed(context, NovoEndereco.nomeTela);
          _enderecoEntregaAtual = novoEndereco;
          if (novoEndereco != null) {
            setState(() {
              _enderecosEntrega.add(novoEndereco);
            });
          }
        }
      },
      onSaved: (Endereco opcao) {
        _enderecoEntregaSelecionado = opcao;
      },
      validator: _validarOpcaoEndereco,
    );
  }

  /// Avalia a opcao de pagamento seguindo as regras definidas para a avaliação.
  String _validarOpcaoPagamento(String s) {
    if (s == null) {
      return 'Escolha uma forma.';
    }
    return null;
  }

  /// Avalia o endereço de entrega seguindo as regras definidas para a avaliação.
  String _validarOpcaoEndereco(Endereco e) {
    if (e == null || e == _valueOutroEndereco) {
      return 'Escolha um endereco.';
    }
    return null;
  }

  _acaoBotaoPedir() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _enviaPedidoBancoDados(context);
      Navigator.pop(context, true);
    }
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
