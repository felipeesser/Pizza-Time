import 'package:flutter/material.dart';
import 'package:pizza_time/modelo/carrinho.dart';
import 'package:pizza_time/telas/home_files/Detalhes.dart';
import 'package:pizza_time/telas/home_files/home_files_components/Pedidos_Feitos_Card.dart';
import 'package:pizza_time/api/pedido_firebase.dart' as pedidoFirebaseCrud;
import 'package:pizza_time/modelo/pedido.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Pedidos_Feitos extends StatefulWidget {
  static final nomeTela = "/pedidos_feitos";

  @override
  _Pedidos_FeitosState createState() => _Pedidos_FeitosState();
}

class _Pedidos_FeitosState extends State<Pedidos_Feitos> {
  Future<bool> _consultouFirebase;
  List<Pedido> _pedidosUsuario;
  String _endereco;
  String _pagamento;
  Carrinho carrinho;
  @override
  initState() {
    super.initState();
    _consultouFirebase = _consultaFirebase();
  }

  Future<bool> _consultaFirebase() async {
    var id = (await FirebaseAuth.instance.currentUser()).uid;
    _pedidosUsuario = await pedidoFirebaseCrud.pedidosFromUsuario(id);
    return _pedidosUsuario != null ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pedidos feitos"),
        ),
        body: FutureBuilder(
            future: _consultouFirebase,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  !snapshot.hasError) {
                return ListView.builder(
                    itemCount: _pedidosUsuario.length,
                    itemBuilder: (context, indice) => GestureDetector(
                          child: Pedidos_Feitos_Card(
                              _pedidosUsuario.elementAt(indice)),
                          onTap: () {
                            Navigator.of(context).pushNamed(Detalhes.nomeTela);
                          },
                        ));
              } else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                return Text("Carregando...");
              }
            }));
  }
}
