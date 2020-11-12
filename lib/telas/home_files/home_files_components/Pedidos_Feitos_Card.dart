import 'package:flutter/material.dart';
class Pedidos_Feitos_Card extends StatelessWidget {
    String _nome;
    String _endereco;
    String _pagamento;
    List<String> _pedidos;
    List<String> _qnt;
    Pedidos_Feitos_Card(String nome,String pagamento, String endereco,List<String>pedidos,List<String>qnt){
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
