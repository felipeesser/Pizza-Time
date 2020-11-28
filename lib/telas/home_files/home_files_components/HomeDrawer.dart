import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_time/telas/home_files/Pedidos_Feitos.dart';
import 'package:pizza_time/telas/revisar_pedido/revisar_pedido_usuario.dart';
import '../Alteracao.dart';
import 'package:pizza_time/api/restaurante_firebase.dart'
    as RestauranteFiresStoreCrud;
import 'package:pizza_time/modelo/Restaurante.dart';

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  Restaurante _restaurante;
  Future<bool> _consultouFireBase;

  Future<bool> _consultaFirebase() async {
    _restaurante = await RestauranteFiresStoreCrud.read();
    setState(() {});
    return _restaurante != null ? true : false;
  }

  String restauranteAberto() {
    if (_restaurante == null) {
      return 'Fechado';
    }
    return _restaurante.aberto ? 'Aberto' : 'Fechado';
  }

  @override
  void initState() {
    super.initState();
    _consultouFireBase = _consultaFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              'Perfil',
              style: TextStyle(color: Colors.black),
            ),
            leading: Icon(
              Icons.perm_identity,
              color: Theme.of(context).accentIconTheme.color,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(Alteracao.nomeTela);
            },
          ),
          ListTile(
            title: Text(
              'Pedidos Feitos',
              style: TextStyle(color: Colors.black),
            ),
            leading: Icon(
              Icons.list_alt_rounded,
              color: Theme.of(context).accentIconTheme.color,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(Pedidos_Feitos.nomeTela);
            },
          ),
          ListTile(
            title: Text(
              'Carrinho',
              style: TextStyle(color: Colors.black),
            ),
            leading: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).accentIconTheme.color,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(RevisarPedidoUsuario.nomeTela);
            },
          ),
          ListTile(
            title: Row(
              children: [
                Text(
                  'Restaurante:  ',
                ),
                Text(
                  '${restauranteAberto()}',
                  style: restauranteAberto() == 'Aberto'
                      ? TextStyle(color: Colors.green)
                      : TextStyle(color: Colors.red),
                )
              ],
            ),
            leading: Icon(
              Icons.home,
              color: Theme.of(context).accentIconTheme.color,
            ),
          ),
        ],
      ),
    );
  }
}
