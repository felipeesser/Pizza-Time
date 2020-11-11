import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_time/notifier/ItemNotifier.dart';
import 'package:pizza_time/telas/Info_Item.dart';
import 'package:google_fonts/google_fonts.dart';
class HomeItens extends StatelessWidget {
  ItemNotifier _itemNotifier;
  HomeItens(ItemNotifier itemNotifier){
    this._itemNotifier=itemNotifier;
  }
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: _itemNotifier.listaItens.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: (){
            _itemNotifier.itemAtual=_itemNotifier.listaItens[index];
            Navigator.of(context).pushNamed(Info_Item.nomeTela);
            },
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 13,horizontal: 13),
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _itemNotifier.listaItens[index].imagem!=null? Expanded(child: FittedBox(fit:BoxFit.fill,child: Image.network(_itemNotifier.listaItens[index].imagem))):Image.asset('Imagens/pizza.jpg'),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(flex:1,child: Text(_itemNotifier.listaItens[index].nome.toUpperCase(),overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black,fontWeight:FontWeight.w600,fontSize: 12))),
                        Flexible(flex:2,child: Text('Descricao simplificada do pedido que as vezes pode ser muito grande',maxLines:2,overflow:TextOverflow.ellipsis,style: TextStyle(color: Color.fromRGBO(89, 89, 89, 1),fontSize: 12,))),
                        Divider(),
                        Flexible(flex:1,child: Align(alignment:Alignment.topRight,child: Padding(padding:EdgeInsets.only(right: 5),child: Text('R\$ 45.00',style: TextStyle(color: Colors.black))))),
                      ],
                    ),
                  ),
               ],
            ),
          ),
        );
      },
    );
  }
}
