// ignore: slash_for_doc_comments
/**
EXEMPLO DE USO

```dart
var f = Funcionamento.fromMap({
  '1': {'abertura': '1', 'fechamento': '2'},
  '2': {'abertura': '3'},
  '3': {'fechamento': '4'},
});
var g = Funcionamento.fromMap(f.toMap());
print(g.toMap());
print(f.toMap());
```
*/

/// Armazena os horarios de funcionamento do restaurante para cada dia da semana.
class Funcionamento {
  final Map<String, dynamic> _diasHorarios = {
    // segunda
    '1': {'abertura': '', 'fechamento': ''},
    '2': {'abertura': '', 'fechamento': ''},
    '3': {'abertura': '', 'fechamento': ''},
    '4': {'abertura': '', 'fechamento': ''},
    '5': {'abertura': '', 'fechamento': ''},
    '6': {'abertura': '', 'fechamento': ''},
    '7': {'abertura': '', 'fechamento': ''},
  };

  Funcionamento.fromMap(Map<String, dynamic> diasHorarios) {
    fromMap(diasHorarios);
  }

  fromMap(Map<String, dynamic> diasHorarios) {
    for (var k in diasHorarios.keys) {
      if (_diasHorarios.containsKey(k)) {
        _diasHorarios[k]['abertura'] = diasHorarios[k]['abertura'] ?? '';
        _diasHorarios[k]['fechamento'] = diasHorarios[k]['fechamento'] ?? '';
      }
    }
  }

  Map<String, dynamic> toMap() => {..._diasHorarios};
}
