import 'package:flutter/material.dart';
class Home_Rest_Ped extends StatelessWidget {
  String _nome;
  String _endereco;
  String _pagamento;
  List<String> _pedidos;
  List<String> _qnt;
  Home_Rest_Ped(String nome,String pagamento, String endereco,List<String>pedidos,List<String>qnt){
    this._nome=nome;
    this._pagamento=pagamento;
    this._endereco=endereco;
    this._pedidos=pedidos;
    this._qnt=qnt;
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Nome: '+this._nome),
              IconButton(
                icon: Icon(Icons.call),
                iconSize: 26,
                onPressed: (){},
              ),
            ],
          ),
          Text('Endereço: '+ this._endereco),
          Text('Pedidos:'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                ListView.builder(
                    itemCount: this._pedidos.length,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      return Text('-'+this._pedidos.elementAt(index)+' x'+this._qnt.elementAt(index));
                    })
            ],
          ),
          Text('Forma de Pagamento: '+ this._pagamento)
        ],
      ),
      color: Colors.white,
    );
  }
}
