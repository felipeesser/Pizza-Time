import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pizza_time/modelo/funcionamento.dart';
import 'package:pizza_time/api/funcionamento_firebase.dart'
    as funcionamentoFireBaseCrud;

class FuncionamentoNotifier extends ChangeNotifier {
  Funcionamento _funcionamentoAtual;

  Funcionamento get funcionamentoAtual => _funcionamentoAtual;
  set funcionamentoAtual(Funcionamento value) {
    _funcionamentoAtual = value;
    notifyListeners();
  }
}
