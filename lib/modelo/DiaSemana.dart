
import 'package:flutter/material.dart';

class DiaSemana {
  String _dia;
  TimeOfDay _abertura;

  TimeOfDay get abertura => _abertura;

  set abertura(TimeOfDay value) {
    _abertura = value;
  }

  TimeOfDay _fechamento;

  TimeOfDay get fechamento => _fechamento;

  set fechamento(TimeOfDay value) {
    _fechamento = value;
  }

  String get dia => _dia;

  set dia(String value) {
    _dia = value;
  }

  DiaSemana(String dia, TimeOfDay abertura, TimeOfDay fechamento){
    this._abertura=abertura;
    this._dia=dia;
    this._fechamento=fechamento;
  }

}
