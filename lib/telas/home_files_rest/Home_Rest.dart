import 'package:flutter/material.dart';
import 'package:pizza_time/api/pedido_firebase.dart' as pedidoFirebaseCrud;
import 'package:pizza_time/api/funcionamento_firebase.dart'
    as funcionamentoFireBaseCrud;
import 'package:pizza_time/modelo/pedido.dart';
import 'package:pizza_time/modelo/funcionamento.dart';
import 'package:pizza_time/notifier/funcionamentoNotifier.dart';
import 'package:pizza_time/notifier/pedido_notifier.dart';
import 'package:pizza_time/telas/AbaConversas.dart';
import 'package:pizza_time/telas/home_files_rest/Home_Rest_Ped.dart';
import 'package:pizza_time/telas/home_files_rest/card_pedidos.dart';
import 'package:provider/provider.dart';
import 'Abertura.dart';
import 'Adicionar.dart';

class Home_Rest extends StatefulWidget {
  static final nomeTela = "/home_rest";
  @override
  _Home_RestState createState() => _Home_RestState();
}

class _Home_RestState extends State<Home_Rest> {
  Future<bool> _consultouFirebase;
  List<Pedido> _pedidosRestaurante;
  List<Widget> _widgetOptions;

  @override
  initState() {
    super.initState();
    FuncionamentoNotifier funcionamentoNotifier =
        Provider.of<FuncionamentoNotifier>(context, listen: false);
    funcionamentoFireBaseCrud.getFuncionamento(funcionamentoNotifier);
    _consultouFirebase = _consultaFirebase();
    // List<Widget> _widgetOptions = <Widget>[
    _widgetOptions = <Widget>[
      FutureBuilder(
        future: _consultouFirebase,
        builder: _futureBuilderListView,
      ),
      AbaConversas(),
      Adicionar(),
    ];
  }

  // List<Widget> _widgetOptions = <Widget>[
  //   // ListView(
  //   //   children: <Widget>[
  //   //     Home_Rest_Ped("Alberto", "cartao", "Rua dos bobos 666",
  //   //         ["pizza doce", "pizza de carne seca"], ["1", "2"]),
  //   //     Home_Rest_Ped("Roberto", "dinheiro", "Rua dos bobos 6666",
  //   //         ["pizza doce", "pizza de carne seca"], ["2", "2"]),
  //   //     Home_Rest_Ped("Marreco", "cartao", "Rua dos bobos 66666",
  //   //         ["pizza doce", "pizza de carne seca"], ["1", "3"]),
  //   //   ],
  //   // ),
  //   FutureBuilder(
  //     future: _consultouFirebase,
  //     builder: _futureBuilderListView,
  //   ),
  //   AbaConversas(),
  //   Adicionar(),
  // ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    FuncionamentoNotifier hora =
        Provider.of<FuncionamentoNotifier>(context, listen: false);
    PedidoNotifier _pedidoNotifier =
        Provider.of<PedidoNotifier>(context, listen: false);
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Status:'),
            Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  'Fechado',
                  style: TextStyle(color: Colors.red),
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5))),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              Navigator.of(context).pushNamed(Abertura.nomeTela);
            },
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            label: 'Pedidos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Config',
          ),
        ],
        selectedItemColor: Theme.of(context).iconTheme.color,
        onTap: _onItemTapped,
      ),
    );
  }

  /// Consulta todos os pedidos do restaurante.
  Future<bool> _consultaFirebase() async {
    _pedidosRestaurante = await pedidoFirebaseCrud.pedidosFromRestaurante();
    return _pedidosRestaurante != null ? true : false;
  }

  /// Constrói o widget apropriado dependendo do andamento da consulta aos dados.
  Widget _futureBuilderListView(
      BuildContext context, AsyncSnapshot<bool> snapshot) {
    // Função para auxiliar na legibilidade
    Widget _carregando() {
      return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            Text(
              'Carregando pedidos...',
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
    Widget _conteudoCompleto() {
      return ListView.builder(
        itemCount: _pedidosRestaurante.length,
        itemBuilder: (context, indice) =>
            CardPedido(_pedidosRestaurante[indice]),
      );
    }

    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return _algoDeuErrado();
      } else {
        return _conteudoCompleto();
      }
    } else {
      return _carregando();
    }
  }
}
