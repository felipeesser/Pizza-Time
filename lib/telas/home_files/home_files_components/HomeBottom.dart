import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_time/telas/revisar_pedido/revisar_pedido_usuario.dart';
class HomeBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        padding: EdgeInsets.symmetric(horizontal: 32),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
        ),
        color: Colors.white,
        onPressed: () {Navigator.of(context).pushNamed(RevisarPedidoUsuario.nomeTela);},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Pedidos:'),
            Icon(Icons.shopping_cart,color: Color.fromRGBO(204, 41, 0, 1),),
          ],
        )
    );
  }
}
