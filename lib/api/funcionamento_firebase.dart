// ignore: slash_for_doc_comments
/**
EXEMPLO DE USO

```dart
import '.../funcionamento_firebase.dart' as funcionamentoFirebaseCrud;
import '.../funcionamento.dart';
...
var funcionamento = Funcionamento.fromMap({
  '1': {'abertura': '1', 'fechamento': '2'},
  '2': {'abertura': '3'},
  '3': {'fechamento': '4'},
});

// CREATE
funcionamentoFirebaseCrud.create(funcionamento);
print(funcionamento.toMap());

// READ
var lidoCriado = await funcionamentoFirebaseCrud.read();
print(lidoCriado.toMap());

// UPDATE
funcionamentoFirebaseCrud.update(lidoCriado
  ..fromMap({
    '6': {'abertura': '111'}
  }));

// READ
var lidoAtualizado = await funcionamentoFirebaseCrud.read();
print(lidoAtualizado.toMap());

// DELETE
funcionamentoFirebaseCrud.delete();

// READ
var lidoDeletado = await funcionamentoFirebaseCrud.read();
print(
    '${lidoDeletado?.toMap() == null ? 'Não existe um registro de funcionamento no documento fornecido.' : lidoDeletado.toMap()}');
```
*/

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pizza_time/modelo/funcionamento.dart';
import 'package:pizza_time/notifier/funcionamentoNotifier.dart';

const pathFuncionamentoRestaurante =
    '/restaurante/unico/funcionamento/diasHorarios';

/// Armazena Firebase um novo documento o [funcionamento] do restaurante.
///
/// O [funcionamento] fornecido será armazenado no restaurante do Firebase.
///
/// ```dart
/// ...
/// await create(horariosFuncionamento);
/// ...
/// ```
void create(Funcionamento funcionamento) async {
  DocumentReference novoDocumentoRestaurante =
      Firestore.instance.document(pathFuncionamentoRestaurante);
  await novoDocumentoRestaurante.setData(funcionamento.toMap(), merge: false);
}

/// Retorna um objeto [Funcionamento] com o funcionamento do restaurante.
///
/// Retorna null se o documento não existir.
///
/// ```dart
/// ...
/// Pedido funcionamentoAtual = await read();
/// ...
/// ```
Future<Funcionamento> read() async {
  final snapshot =
      await Firestore.instance.document(pathFuncionamentoRestaurante).get();
  return snapshot.data == null ? null : Funcionamento.fromMap(snapshot.data);
}

/// Atualiza o [funcionamento] no Firebase, com o valor atual do [funcionamento].
///
/// ```dart
/// ...
/// update(horariosFuncionamento);
/// ...
/// ```
void update(Funcionamento funcionamento) async {
  DocumentReference documento =
      Firestore.instance.document(pathFuncionamentoRestaurante);
  await documento.updateData(funcionamento.toMap());
}

/// Remove do Firebase as informações sobre o [funcionamento] do restaurante.
///
/// ```dart
/// ...
/// delete();
/// ...
/// ```
void delete() async {
  DocumentReference documento =
      Firestore.instance.document(pathFuncionamentoRestaurante);
  await documento.delete();
}

// =============================================================================

getFuncionamento(FuncionamentoNotifier funcionamentoNotifier) async {
  funcionamentoNotifier.funcionamentoAtual = await read();
}
