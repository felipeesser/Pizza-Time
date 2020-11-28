import 'package:flutter/material.dart';
import 'package:pizza_time/api/pedido_firebase.dart' as pedidoFirebaseCrud;
import 'package:pizza_time/api/funcionamento_firebase.dart'
    as funcionamentoFireBaseCrud;
import 'package:pizza_time/modelo/Restaurante.dart';
import 'package:pizza_time/modelo/pedido.dart';
import 'package:pizza_time/notifier/funcionamentoNotifier.dart';
import 'package:pizza_time/notifier/pedido_notifier.dart';
import 'package:pizza_time/telas/home_files_rest/card_pedidos.dart';
import 'package:provider/provider.dart';
import 'package:pizza_time/api/restaurante_firebase.dart'
    as restauranteFireBaseCrud;
import 'Abertura.dart';
import 'Adicionar.dart';

class Home_Rest extends StatefulWidget {
  static final nomeTela = "/home_rest";
  @override
  _Home_RestState createState() => _Home_RestState();
}

class _Home_RestState extends State<Home_Rest> {
  Future<bool> _consultouFirebase;
  Restaurante _restaurante;
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
        builder: _futureBuilder,
      ),
      Adicionar(),
    ];
  }

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

    String restauranteAberto() {
      if (_restaurante == null) {
        return 'Fechado';
      }
      return _restaurante.aberto ? 'Aberto' : 'Fechado';
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
                child: GestureDetector(
                  child: Text(
                    restauranteAberto(),
                    style: restauranteAberto() == 'Aberto'
                        ? TextStyle(color: Colors.green)
                        : TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    if (_restaurante == null) {
                      return;
                    }
                    restauranteFireBaseCrud
                        .update(_restaurante..aberto = !_restaurante.aberto);
                    setState(() {});
                  },
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
    _restaurante = await restauranteFireBaseCrud.read();
    _pedidosRestaurante = await pedidoFirebaseCrud.pedidosFromRestaurante();
    setState(() {});
    return _pedidosRestaurante != null ? true : false;
  }

  /// Retorna o widget que será mostrado na tela
  ///
  /// O widget que será mostrado depende do status da snapshot.
  Widget _futureBuilder(BuildContext context, AsyncSnapshot<bool> snapshot) {
    /// Mostra um circulo para sinalizar o carregamento.
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

    /// Mostra aviso.
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

    /// Mostra o widget que deveria ser mostrado de início.
    Widget _conteudoCompleto() {
      return ListView.builder(
        itemCount: _pedidosRestaurante.length,
        itemBuilder: (context, indice) =>
            CardPedido(_pedidosRestaurante[indice]),
      );
    }

    /// Decide o que será mostrado
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
