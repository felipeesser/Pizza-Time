import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_time/DiaSemana.dart';

class Abertura extends StatefulWidget {
  @override
  _AberturaState createState() => _AberturaState();
}

class _AberturaState extends State<Abertura> {
  List<DiaSemana> _dias=[DiaSemana("Segunda",TimeOfDay.now(),TimeOfDay.now()),
    DiaSemana("Terça",TimeOfDay.now(),TimeOfDay.now()),
    DiaSemana("Quarta",TimeOfDay.now(),TimeOfDay.now()),
    DiaSemana("Quinta",TimeOfDay.now(),TimeOfDay.now()),
    DiaSemana("Sexta",TimeOfDay.now(),TimeOfDay.now()),
    DiaSemana("Sábado",TimeOfDay.now(),TimeOfDay.now()),
    DiaSemana("Domingo",TimeOfDay.now(),TimeOfDay.now()),];
  DiaSemana dropdownValue=null;
  TimeOfDay _timei= new TimeOfDay.now();
  TimeOfDay _timef= new TimeOfDay.now();
  Future<Null> _selectTimei(BuildContext context) async{
    final TimeOfDay picked= await showTimePicker(
      context: context,
      initialTime: _timei
    );
    if(picked!=null && picked !=_timei){
      setState((){
        _timei=picked;
        _dias.elementAt(_dias.indexOf(dropdownValue)).abertura=_timei;
      });
    }
  }
  Future<Null> _selectTimef(BuildContext context) async{
    final TimeOfDay picked= await showTimePicker(
        context: context,
        initialTime: _timef
    );
    if(picked!=null && picked !=_timef){
      setState((){
        _timef=picked;
        _dias.elementAt(_dias.indexOf(dropdownValue)).fechamento=_timef;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horário de Funcionamento'),
        centerTitle: true,
      ),
       body: Column(
         children: [
           Text("Horário de Funcionamento:"),
           Table(
             border: TableBorder.all(),
             children: _dias.map((e) => TableRow(
                 children: [Text(e.dia),
                   Text('${e.abertura.hour}:${e.abertura.minute}'),
                 Text('${e.fechamento.hour}:${e.fechamento.minute}')])).toList()
           ),
           Text('Editar Horário:'),
           DropdownButton<DiaSemana>(
             value: dropdownValue==null?_dias.elementAt(0):dropdownValue,
             icon: Icon(Icons.arrow_drop_down),
             onChanged: (DiaSemana newValue) {
               setState(() {
                 dropdownValue = newValue;
               });
             },
             items: _dias.map((DiaSemana dia) {
               return new DropdownMenuItem<DiaSemana>(
                 value: dia,
                 child: new Text(
                   dia.dia,
                 ),
               );
             }).toList(),
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text('Abertura:'),
               FlatButton(
                 child: Text("${_timei.hour}:${_timei.minute}"),
                 onPressed: (){
                   _selectTimei(context);
                 },
               ),
               Text('Fechamento:'),
               FlatButton(
                 child: Text("${_timef.hour}:${_timef.minute}"),
                 onPressed: (){
                   _selectTimef(context);
                 },
               ),
             ],
           ),
         ],
       ),
    );
  }
}
