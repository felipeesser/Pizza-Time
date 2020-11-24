import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class Home_Rest_Ped extends StatelessWidget {
  void _chamada(String command)async{
    if(await canLaunch(command)){
      await launch(command);
    }
    else{
      print ('erro chamada');
    }
  }
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
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Nome: '+this._nome),
                IconButton(
                  icon: Icon(Icons.call, color: Theme.of(context).iconTheme.color),
                  iconSize: 26,
                  onPressed: (){
                    _chamada('tel:21999999999');
                  },
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
      ),
      color: Colors.white,
    );
  }
}
