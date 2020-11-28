import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_time/notifier/ItemNotifier.dart';
import 'package:provider/provider.dart';
class HomeFilter extends StatefulWidget {
  @override
  _HomeFilterState createState() => _HomeFilterState();
}

class _HomeFilterState extends State<HomeFilter> {
  Widget _filtro(ItemNotifier itemNotifier) {
    return Container(
      height: 200.0,
      width: 200.0,
      child: ListView(
        children: <Widget>[
          ListTile(
            onTap: (){
              itemNotifier.palavraAtual='';
              itemNotifier.filtroAtual=3;
            },
            title: Text(
              'Todas',
              style: TextStyle(
                color: Color.fromRGBO(204, 41, 0, 1),
              ),
            ),
          ),
          ListTile(
            onTap: (){
              itemNotifier.palavraAtual='';
              itemNotifier.filtroAtual=1;
            },
            title: Text(
              'Doce',
              style: TextStyle(
                color: Color.fromRGBO(204, 41, 0, 1),
              ),
            ),
          ),
          ListTile(
            onTap: (){
              itemNotifier.palavraAtual='';
              itemNotifier.filtroAtual=0;
            },
            title: Text(
              'Salgada',
              style: TextStyle(color: Color.fromRGBO(204, 41, 0, 1)),
            ),
          ),
          ListTile(
            onTap: (){
              itemNotifier.palavraAtual='';
              itemNotifier.filtroAtual=2;
            },
            title: Text(
              'Vegetariana',
              style: TextStyle(
                color: Color.fromRGBO(204, 41, 0, 1),
              ),
            ),
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    ItemNotifier itemNotifier = Provider.of<ItemNotifier>(context);
    return FlatButton(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.filter_list, size: 25, color: Color.fromRGBO(204, 41, 0, 1))
            ),
            SizedBox(width: 16),
            Align(
                alignment: Alignment.centerLeft,
                child: Text("Filtro", style: TextStyle(color: Color.fromRGBO(89, 89, 89, 1), fontWeight:FontWeight.w100,fontSize: 16),)
            ),
          ],
        ),
      ),
      onPressed: () {setState(() {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Filtro"),
                content: _filtro(itemNotifier),
              );
            });
      });},
      disabledTextColor: Colors.black,
      disabledColor: Colors.white,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(32.0),
        ),
      ),
    );
  }
}
