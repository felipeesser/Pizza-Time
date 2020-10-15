import 'package:flutter/material.dart';
import '../../novo_endereco/novo_endereco_route.dart';
import 'Endereco.dart';

class FormFinalizarPedido extends StatefulWidget {
  @override
  _FormFinalizarPedidoState createState() => _FormFinalizarPedidoState();
}

class _FormFinalizarPedidoState extends State<FormFinalizarPedido> {
  final _formKey = GlobalKey<FormState>();
  String formaPagamento;
  List<String> formasPagamento;
  String enderecoEntrega;
  // will be fetched from database
  List<String> enderecosEntrega;

  @override
  void initState() {
    super.initState();
    formasPagamento = ['Dinheiro', 'Cartão de Crédito', 'Cartão de Débito'];
    enderecosEntrega = enderecosTEMP;
    enderecosEntrega.add('Outro endereço...');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidate: true,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Forma de pagamento:'),
          ),
          _selecionarFormaPagamento(),
          SizedBox(height: 24),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Endereço para entrega:'),
          ),
          _selecionarEnderecoEntrega(context),
        ],
      ),
    );
  }

  _selecionarFormaPagamento() {
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

  _selecionarEnderecoEntrega(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: enderecoEntrega,
      hint: Text('Entregar em...'),
      isExpanded: true,
      items: enderecosEntrega
          .map<DropdownMenuItem<String>>(
            (String s) => DropdownMenuItem(
              value: s,
              child: Text(
                s,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
      onChanged: (String opcao) {
        setState(() {
          enderecoEntrega = opcao;
        });
      },
      validator: (String opcao) {
        if (opcao == 'Outro endereço...') {
          Navigator.pushNamed(context, NovoEnderecoRoute.routeName);
        }
        return;
      },
    );
  }

}
