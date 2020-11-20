/// Armazena os horarios de funcionamento do restaurante para cada dia da semana.
class Funcionamento {
  // Map<int, Map<String, String>> dias = {
  final _diasHorarios = {
    1: {'abertura': '', 'fechamento': ''},
    2: {'abertura': '', 'fechamento': ''},
    3: {'abertura': '', 'fechamento': ''},
    4: {'abertura': '', 'fechamento': ''},
    5: {'abertura': '', 'fechamento': ''},
    6: {'abertura': '', 'fechamento': ''},
    7: {'abertura': '', 'fechamento': ''},
  };

  Funcionamento.fromMap(Map<int, Map<String, String>> diasHorarios) {
    fromMap(diasHorarios);
  }

  fromMap(Map<int, Map<String, String>> diasHorarios) {
    for (var k in diasHorarios.keys) {
      if (_diasHorarios.containsKey(k)) {
        _diasHorarios[k]['abertura'] = diasHorarios[k]['abertura'] ?? '';
        _diasHorarios[k]['fechamento'] = diasHorarios[k]['fechamento'] ?? '';
      }
    }
  }

  Map<int, Map<String, String>> toMap() => {..._diasHorarios};
}
