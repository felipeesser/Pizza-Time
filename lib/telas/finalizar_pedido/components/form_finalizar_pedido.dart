import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:pizza_time/api/endereco_firebase.dart' as enderecoFirebaseCrud;
import 'package:pizza_time/modelo/endereco.dart';
import 'package:pizza_time/telas/novo_endereco/novo_endereco.dart';

/// Constrói um formulário para a finalização da entrega.
///
/// Os campos desse formulário são modo de pagamento, e endereço para entrega.
///
/// ```dart
/// ...
/// child: FormFinalizarPedido(),
/// ...
/// ```
class FormFinalizarPedido extends StatefulWidget {
  @override
  _FormFinalizarPedidoState createState() => _FormFinalizarPedidoState();
}

class _FormFinalizarPedidoState extends State<FormFinalizarPedido> {
  final _formKey = GlobalKey<FormState>();
  String formaPagamento;
  final formasPagamento = const [
    'Dinheiro',
    'Cartão de Crédito',
    'Cartão de Débito'
  ];
  // String _idEnderecoSelecionado;
  Endereco _enderecoEntregaSelecionado;
  List<Endereco> _enderecosEntrega;
  final _labelOutroEndereco = 'Outro endereço...';
  final _valueOutroEndereco = Endereco();

  @override
  void initState() async {
    super.initState();
    // TODO - checar se utilizaremos provider para o usuario ou não;
    var usuarioAux = await FirebaseAuth.instance.currentUser();
    _enderecosEntrega =
        await enderecoFirebaseCrud.endrecosFromUsuario(usuarioAux.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidate: true,
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
      value: formaPagamento,
      hint: Text('Forma de pagamento...'),
      items: formasPagamento
          .map<DropdownMenuItem<String>>(
              (String s) => DropdownMenuItem(value: s, child: Text(s)))
          .toList(),
      onChanged: (String opcao) {
        setState(() {
          formaPagamento = opcao;
        });
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
      onChanged: (String opcao) {
        setState(() {
          enderecoEntrega = opcao;
        });
      },
      validator: (String opcao) {
        if (opcao == _labelOutroEndereco) {
          _navegarMostrarNovoEnderecoRoute();
          // se necessário tratar excessões
        }
        return;
      },
    );
  }

  /// Empurra a tela NovoEndereço no Navegador.
  _navegarMostrarNovoEnderecoRoute() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.pushNamed(context, NovoEndereco.nomeTela);
    });
  }
}
