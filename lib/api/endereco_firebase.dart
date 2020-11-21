// ignore: slash_for_doc_comments
/**
EXEMPLO DE USO

```dart
import '.../endereco_firebase.dart' as enderecoFirebaseCrud;
...
var endereco = Endereco(rua: 'aaa', numero: '000', complemento: 'apartamento 0');
String idUsuario = 'algumUuidUsuario';
...
// CREATE
enderecoFiresbaseCrud.create(endereco, idUsuario);
print(endereco.toMap());

// READ
var documento = Firestore.instance.document(
    '/usuarios/$idUsuario/enderecos/${endereco.idEndereco}'
);
var lidoCriado = await enderecoFiresbaseCrud.read(documento);
print(lidoCriado.toMap());

// UPDATE
enderecoFiresbaseCrud.update(
  endereco
    ..rua = 'bbb',
  idUsuario
);

// READ
var lidoAtualizado = await enderecoFiresbaseCrud.read(documento);
print(lidoAtualizado.toMap());

// DELETE
enderecoFiresbaseCrud.delete(endereco, idUsuario);

// READ
var lidoDeletado = await enderecoFiresbaseCrud.read(documento);
print('${lidoDeletado?.toMap()==null ? 'Não existe um endereco no documento fornecido.': lidoDeletado.toMap()}');
```
*/

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pizza_time/modelo/endereco.dart';

const pathEnderecos = '/usuarios/$replaceToken/enderecos';
const replaceToken = '-replaceToken';

/// Armazena no banco de dados um novo documento com o [endereco] fornecido.
///
/// O [endereço] fornecido será armazenado na coleção de endereços do usuario
/// definido com o [idUsuario] fornecido.
///
/// ```dart
/// ...
/// await create(casa, usuario.idUsuario);
/// ...
/// ```
void create(Endereco endereco, String idUsuario) async {
  DocumentReference novoDocumento = Firestore.instance
      .collection(pathEnderecos.replaceAll(replaceToken, idUsuario))
      .document();
  endereco.idEndereco = novoDocumento.documentID;
  await novoDocumento.setData(endereco.toMap(), merge: false);
}

/// Lê o [documento] e retorna um endereco com os dados lidos.
///
/// Retorna null se o documento não existir.
///
/// ```dart
/// ...
/// Item aux = await read(refEmpresaUsuario);
/// ...
/// ```
Future<Endereco> read(DocumentReference documento) async {
  final snapshot = await documento?.get();
  return snapshot.data == null ? null : Endereco.fromMap(snapshot.data);
}

/// Atualiza o [endereco] no firestore, com o valor atual do [endereco].
///
/// ```dart
/// ...
/// await update(enderecoCasaVeraneio, usuario.idUsuario);
/// ...
/// ```
void update(Endereco endereco, String idUsuario) async {
  DocumentReference documento = Firestore.instance
      .collection(pathEnderecos.replaceAll(replaceToken, idUsuario))
      .document(endereco.idEndereco);
  await documento.updateData(endereco.toMap());
}

/// Remove do firestore o [enedreco] armazenado na coleção de endereços do [usuario].
///
/// ```dart
/// ...
/// await delete(casaEx, usuario.idUsuario);
/// ...
/// ```
void delete(Endereco endereco, String idUsuario) async {
  DocumentReference documento = Firestore.instance
      .collection(pathEnderecos.replaceAll(replaceToken, idUsuario))
      .document(endereco.idEndereco);
  await documento.delete();
}
