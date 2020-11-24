import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_time/modelo/DiaSemana.dart';
import 'package:pizza_time/api/funcionamento_firebase.dart'
    as funcionamentoFirebaseCrud;
import 'package:pizza_time/modelo/funcionamento.dart';

class Abertura extends StatefulWidget {
  static final nomeTela = "/abertura";
  @override
  _AberturaState createState() => _AberturaState();
}

class _AberturaState extends State<Abertura> {
  List<DiaSemana> _dias; //= [
  @override
  void initState() {
    super.initState();
    defineHorario();
    print(_dias);
  }

  defineHorario() async {
    var dados = await funcionamentoFirebaseCrud.read();
    if (dados != null) {
      print('1234567');
      var hora = dados.toMap();
      // print(dados.toMap());
      // print(hora);
      this._dias = [
        DiaSemana("Segunda", hora['1']['abertura'], hora['1']['fechamento']),
        DiaSemana("Terça", hora['2']['abertura'], hora['2']['fechamento']),
        DiaSemana("Quarta", hora['3']['abertura'], hora['3']['fechamento']),
        DiaSemana("Quinta", hora['4']['abertura'], hora['4']['fechamento']),
        DiaSemana("Sexta", hora['5']['abertura'], hora['5']['fechamento']),
        DiaSemana("Sábado", hora['6']['abertura'], hora['6']['fechamento']),
        DiaSemana("Domingo", hora['7']['abertura'], hora['7']['fechamento']),
      ];
    } else {
      _dias = [
        DiaSemana("Segunda", "10:00", "10:00"),
        DiaSemana("Terça", "10:00", "10:00"),
        DiaSemana("Quarta", "10:00", "10:00"),
        DiaSemana("Quinta", "10:00", "10:00"),
        DiaSemana("Sexta", "10:00", "10:00"),
        DiaSemana("Sábado", "10:00", "10:00"),
        DiaSemana("Domingo", "10:00", "10:00"),
      ];
    }
  }

  DiaSemana dropdownValue = null;
  TimeOfDay _timei = new TimeOfDay.now();
  TimeOfDay _timef = new TimeOfDay.now();
  Future<Null> _selectTimei(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: _timei);
    if (picked != null && picked != _timei) {
      setState(() {
        _timei = picked;
        if (dropdownValue != null)
          _dias.elementAt(_dias.indexOf(dropdownValue)).abertura =
              '${_timei.hour}:${_timei.minute}';
        else
          _dias.elementAt(0).abertura = '${_timei.hour}:${_timei.minute}';
      });
    }
  }

  Future<Null> _selectTimef(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: _timef);
    if (picked != null && picked != _timef) {
      setState(() {
        _timef = picked;
        if (dropdownValue != null)
          _dias.elementAt(_dias.indexOf(dropdownValue)).fechamento =
              '${_timef.hour}:${_timef.minute}';
        else
          _dias.elementAt(0).fechamento = '${_timef.hour}:${_timef.minute}';
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
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Horário de Funcionamento:"),
                Table(
                    border: TableBorder.all(),
                    children: _dias
                        .map((e) => TableRow(children: [
                              Text(e.dia),
                              Text('${e.abertura}'),
                              Text('${e.fechamento}')
                            ]))
                        .toList()),
                Text('Editar Horário:'),
                DropdownButton<DiaSemana>(
                  value: dropdownValue == null
                      ? _dias.elementAt(0)
                      : dropdownValue,
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
                Table(
                  children: [
                    TableRow(children: [
                      Center(child: Text('Abertura:')),
                      Center(child: Text('Fechamento:')),
                    ]),
                    TableRow(
                      children: [
                        FlatButton(
                          child: Text("${_timei.hour}:${_timei.minute}"),
                          onPressed: () {
                            _selectTimei(context);
                          },
                        ),
                        FlatButton(
                          child: Text("${_timef.hour}:${_timef.minute}"),
                          onPressed: () {
                            _selectTimef(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                FlatButton(
                    onPressed: () async {
                      var horario = Funcionamento.fromMap({
                        '1': {
                          'abertura': '${_dias.elementAt(0).abertura}',
                          'fechamento': '${_dias.elementAt(0).fechamento}'
                        },
                        '2': {
                          'abertura': '${_dias.elementAt(1).abertura}',
                          'fechamento': '${_dias.elementAt(1).fechamento}'
                        },
                        '3': {
                          'abertura': '${_dias.elementAt(2).abertura}',
                          'fechamento': '${_dias.elementAt(2).fechamento}'
                        },
                        '4': {
                          'abertura': '${_dias.elementAt(3).abertura}',
                          'fechamento': '${_dias.elementAt(3).fechamento}'
                        },
                        '5': {
                          'abertura': '${_dias.elementAt(4).abertura}',
                          'fechamento': '${_dias.elementAt(4).fechamento}'
                        },
                        '6': {
                          'abertura': '${_dias.elementAt(5).abertura}',
                          'fechamento': '${_dias.elementAt(5).fechamento}'
                        },
                        '7': {
                          'abertura': '${_dias.elementAt(6).abertura}',
                          'fechamento': '${_dias.elementAt(6).fechamento}'
                        }
                      });
                      if (await funcionamentoFirebaseCrud.read() == null) {
                        funcionamentoFirebaseCrud.create(horario);
                      } else {
                        funcionamentoFirebaseCrud.update(horario);
                      }
                    },
                    child: Text("Atualizar"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
