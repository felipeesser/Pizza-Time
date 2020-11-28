import 'package:flutter/material.dart';
import 'package:pizza_time/modelo/funcionamento.dart';

class FuncionamentoNotifier extends ChangeNotifier {
  Funcionamento _funcionamentoAtual;

  Funcionamento get funcionamentoAtual => _funcionamentoAtual;
  set funcionamentoAtual(Funcionamento value) {
    _funcionamentoAtual = value;
    notifyListeners();
  }
}
