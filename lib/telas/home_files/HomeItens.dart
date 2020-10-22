import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_time/telas/Item.dart';
class HomeItens extends StatelessWidget {
  AsyncSnapshot _snapshot;
  HomeItens(AsyncSnapshot snapshot){
    this._snapshot=snapshot;
  }
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: _snapshot.data.documents.map<Widget>((DocumentSnapshot doc) {
        return GestureDetector(
          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Item())),
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
            ),
            child: Column(
              children: <Widget>[
                Image.asset('Imagens/pizza.jpg'),
                Text(doc.data['nome'],style: TextStyle(fontWeight: FontWeight.bold),),
                Spacer()],
            ),
          ),
        );
      }).toList(),
    );
  }
}
