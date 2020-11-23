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
    ..rua = 'Rua dos bobos',
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
import 'package:pizza_time/modelo/pedido.dart';

const _pathEnderecos = '/usuarios/$_replaceToken/enderecos';
const _replaceToken = '-replaceToken';

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
void create({Endereco endereco, String idUsuario}) async {
  if (endereco == null || idUsuario == null) {
    return;
  }
  DocumentReference novoDocumento = _colecaoEnderecos(idUsuario).document();
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
void update({Endereco endereco, String idUsuario}) async {
  if (endereco == null || idUsuario == null) {
    return;
  }
  DocumentReference documento =
      _documentoEndereco(idEndereco: endereco.idEndereco, idUsuario: idUsuario);
  await documento.updateData(endereco.toMap());
}

/// Remove um endereco de um usuario.
///
/// Remove do firestore o endereco com [idEndereco] armazenado na coleção de
/// endereços do usuario com idUsuario.
///
/// ```dart
/// ...
/// await delete(CasaEx.idEndereco, usuario.idUsuario);
/// ...
/// ```
void delete({String idEndereco, String idUsuario}) async {
  DocumentReference documento =
      _documentoEndereco(idEndereco: idEndereco, idUsuario: idUsuario);
  await documento.delete();
}

/// Retorna o documento onde o [idEndereco] de um dado [idusuario] está armazenado.
///
///```dart
/// DocumentReference documento = _documentoEndereco(
///   idUsuario: uuidUsuario,
///   idEndereco: uuidEnderecoUsuario
/// );
///```
DocumentReference _documentoEndereco({String idUsuario, String idEndereco}) {
  return Firestore.instance.document(
      '${_pathEnderecos.replaceAll(_replaceToken, idUsuario)}/$idEndereco');
}

/// Retorna a colecao de enderecos do usuario com [idUsuario].
///
///```dart
/// String path = colecaoEnderecos(uuidUsuario);
///```
CollectionReference _colecaoEnderecos(String idUsuario) {
  return Firestore.instance.collection(
    _pathEnderecos.replaceAll(_replaceToken, idUsuario),
  );
}

/// Retorna um [Endereco] a partir do [Pedido] fornecido.
Future<Endereco> enderecoFromPedido(Pedido pedido) => read(
      _documentoEndereco(
          idEndereco: pedido.idEndereco, idUsuario: pedido.idUsuario),
    );

/// Retorna uma lista de [Endereco] que pertencem ao usuario com [iDusuario].
Future<List<Endereco>> endrecosFromUsuario(String idUsuario) async {
  List<Endereco> enderecos;
  final snapshots = await _colecaoEnderecos(idUsuario).getDocuments();
  final documentos = snapshots.documents;
  for (DocumentSnapshot doc in documentos) {
    Endereco endereco = Endereco.fromMap(doc.data);
    enderecos.add(endereco);
  }
  return enderecos;
}
