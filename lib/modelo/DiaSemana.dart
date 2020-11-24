
import 'package:flutter/material.dart';

class DiaSemana {
  String _dia;
  String _abertura;
  String _fechamento;

  String get abertura => _abertura;

  set abertura(String value) {
    _abertura = value;
  }

  String get fechamento => _fechamento;

  set fechamento(String value) {
    _fechamento = value;
  }

  String get dia => _dia;

  set dia(String value) {
    _dia = value;
  }

  DiaSemana(String dia, String abertura, String fechamento){
    this._abertura=abertura;
    this._dia=dia;
    this._fechamento=fechamento;
  }

}
